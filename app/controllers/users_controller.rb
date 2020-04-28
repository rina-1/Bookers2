class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show,:edit,:index]
  before_action :correct_user, only: [:edit, :update]


  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = Book.all
  end

  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def edit
  	   @user = User.find(params[:id])
       if @user != current_user
        redirect_to user_path(current_user)
      end
  end
  def update
  	@user = User.find(params[:id])
   if @user.update(user_params)
      flash[:notice] = "You have update User successfully"
  	  redirect_to current_user
    else
      render :edit
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:text,:body)
  end
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

end
