class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:show,:edit,:index]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created Book successfully"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
  end
  end
  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
    @user = Book.find(params[:id]).user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to book_path(@book)
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have update Book successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to users_path
    end
  end
  private
  def book_params
  	params.require(:book).permit(:title,:body)
  end
   def correct_user
    book = Book.find(params[:id])
    if current_user != book.user
      redirect_to books_path
    end
  end
end