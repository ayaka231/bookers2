class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
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
    @books = Book.find(params[:id])
    @user = @books.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book)
    else
    render :edit
    end
    flash[:notice] = "You have updated book successfully."
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

   def book_params
     params.require(:book).permit(:title, :body)
   end
end
