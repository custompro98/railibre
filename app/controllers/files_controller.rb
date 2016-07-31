class FilesController < ApplicationController
  def index
    # Displays the form
  end

  def download
    begin
      download_book_with_id(params[:id])
    rescue
      flash.alert = 'Book could not be downloaded.'
      redirect_to root_path
    end
  end

  def upload
    # Does the heavylifting for upload
    uploaded_io = params[:ebook]
    file_path = write_file(uploaded_io)

    add_file_to_calibre_library(file_path)

    flash.notice = "Book uploaded successfully."
    redirect_to root_path
  end

  private

  def download_book_with_id(book_id)
    file = BookFile.find_by("book = ?", book_id)
    path = Rails.root.join('public', 'calibre-library', "#{file.book.path}", "#{file.name}.#{file.format}")

    flash.notice = 'Book downloaded successfully.'
    send_file path
  end

  def write_file(uploaded_io)
    file_content = uploaded_io.tempfile.read
    file_content.force_encoding('UTF-8')

    file_path = Rails.root.join('public', 'uploads', uploaded_io.original_filename)

    File.open(file_path, 'w') do |file|
      file.write(file_content)
    end

    file_path
  end

  def add_file_to_calibre_library(ebook_file)
    # Performs the system calls to add the book to calibre
  end
end
