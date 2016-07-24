class FilesController < ApplicationController
  include ERB::Util

  def download
    begin
      download_book_with_id(params[:id])
    rescue
      flash.alert = 'Book could not be downloaded.'
      redirect_to root_path
    end
  end

  private

  def download_book_with_id(book_id)
    file = BookFile.find_by("book = ?", book_id)
    path = File.join(Rails.root, 'public', 'calibre-library', "#{file.book.path}", "#{file.name}.#{file.format}")

    flash.notice = 'Book downloaded successfully.'
    send_file path
  end
end
