class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def new
    @book = Book.new
  end

  def create
    @books = Book.all
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else
     render action: :index
    end
  end

  def show
    @book = Book.new
    @book1 = Book.find(params[:id])
    @user = @book1.user
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path(@book.id)
    else
     render action: :edit
    end
  end

  def destroy
    @book1 = Book.find(params[:id])
    @book1.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
