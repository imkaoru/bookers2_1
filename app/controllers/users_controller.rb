class UsersController < ApplicationController
  # before_action :correct_user, only: [:edit]

  def index
    @logging_in_user = current_user
    @new_book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    # @user = current_user

    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(user_path(current_user.id)) unless current_user?(@user)
  # end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
