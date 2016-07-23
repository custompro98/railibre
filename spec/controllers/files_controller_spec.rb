require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  describe "#download" do
    context "cannot load file path" do
      it "redirects to the home page with an alert" do
        invalid_book_id = '0'

        get :download, { id: invalid_book_id }

        expect(response).to redirect_to root_path
      end
    end

    context "file path loaded" do
      it "downloads the book" do
        book = create(:book, id: 1, path: 'Pride and Prejudice')
        book.path = 'Pride and Prejudice'

        get :download, { id: book.id }

        expect(controller).to have_received(:send_file).with(book.path)
      end
    end
  end
end
