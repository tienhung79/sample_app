class AccountActivationsController < ApplicationController
  before_action :find_user, only: :edit
  
  def edit
    if !@user.activated && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:success] = t("account_activated")
      redirect_to @user
    else
      flash[:danger] = t("invalid_link")
      redirect_to root_url
    end
  end

  private

  def find_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:alert] = t("not_find_user")
    redirect_to root_path
  end
end
