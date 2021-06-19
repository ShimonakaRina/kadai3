class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
    @users = User.all
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:title, :body, :profile_image)
  end
end
