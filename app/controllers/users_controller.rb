class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all 
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if   @user.update(user_params)
         flash[:notice] = "Successfully"
         redirect_to user_path(current_user)
    else
         flash[:notice] = "error"
         @user = User.find(params[:id])
         render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

  

end