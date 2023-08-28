class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update destroy)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show; end

  def new
    @user = User.new
  end

  def index
    @pagy, @users = pagy(User.all, items: Settings.digits.num_of_page)
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t("notification")
      log_in @user
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t("profile_updated")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("user_deleted")
    else
      flash[:danger] = t("delete_fail")
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:alert] = t("not_find_user")
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t("please_log_in")
    store_location
    redirect_to login_url
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t("cannot_edit")
    redirect_to root_url
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
    flash[:alert] = t("not_permission")
  end
end
