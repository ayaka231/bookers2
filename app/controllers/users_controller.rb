class UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @users = User.all
    if @book.save
    redirect_to book_path(@book)
    else
     @user = current_user
     render :index
    end
    flash[:notice] = "You have created book successfully."
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    else
     render :edit
    end
    flash[:notice] = "You have updated user successfully."
  end

  private

   def user_params
     params.require(:user).permit(:name, :introduction, :profile_image)
   end

   def book_params
     params.require(:book).permit(:title, :body)
   end

end
