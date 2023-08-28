class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warming] = "Not found user!"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      # Handle a successful save.
    else
      render :new
    end
  end
end
