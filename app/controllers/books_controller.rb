class BooksController < ApplicationController
  def index
  end

  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save
    redirect_to book_id_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
