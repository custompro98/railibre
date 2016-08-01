require 'os'

class FilesController < ApplicationController
  def index
    # Displays the form
  end

  def download
    begin
      download_book_with_id(params[:id])
      flash.notice = 'Book downloaded successfully.'
    rescue
      flash.alert = 'Book could not be downloaded.'
      redirect_to root_path
    end
  end

  def upload
    uploaded_io = params[:ebook]
    book_path = write_file(uploaded_io)

    if add_book_to_calibre_library(book_path)
      flash.notice = "Book added to the Calibre library successfully"
    else
      flash.alert = "Book not added to the Calibre library."
    end

    redirect_to root_path
  end

  private

  def download_book_with_id(book_id)
    file = BookFile.find_by("book = ?", book_id)
    path = File.join(calibre_path, book_path(file))

    send_file path
  end

  def write_file(uploaded_io)
    file_content = uploaded_io.tempfile.read
    file_content.force_encoding('UTF-8')

    book_path = File.join(upload_path, uploaded_io.original_filename)

    File.open(book_path, 'w') do |file|
      file.write(file_content)
    end

    book_path
  end

  def add_book_to_calibre_library(book_path)
    if OS.mac?
      system("/Applications/calibre.app/Contents/MacOS/calibredb add #{Shellwords.escape(book_path)} --library-path #{calibre_path}")
    elsif OS.linux?
      system("calibredb add #{Shellwords.escape(book_path)} --library-path #{calibre_path}")
    else
      false
    end
  end

  private

  def book_path(ebook_file)
    File.join("#{ebook_file.book.path}", "#{ebook_file.name}.#{ebook_file.format}")
  end

  def calibre_path
    Rails.root.join('public', 'calibre-library')
  end

  def upload_path
    Rails.root.join('public', 'uploads')
  end
end
