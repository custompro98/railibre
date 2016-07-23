class FilesController < ApplicationController
  include ERB::Util

  def download
    begin
      file = BookFile.find_by("book = ?", params[:id])
      path = File.join(Rails.root, 'public', 'calibre-library', "#{file.book.path}", "#{file.name}.#{file.format}")

      flash.notice = 'Book downloaded successfully.'
      send_file path
    rescue
      flash.alert = 'Book could not be downloaded.'
      redirect_to root_path
    end
  end
end
