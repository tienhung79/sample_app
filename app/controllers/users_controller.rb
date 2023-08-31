class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update destroy)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :logged_in_user, except: %i(new create show)
  # before_action :load_user, except: %i(index new create)

  def show;
    @page, @microposts = pagy @user.microposts, items: Settings.digits.page_10
  end

  def new
    @user = User.new
  end

  def index
    @pagy, @users = pagy(User.all, items: 10)
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("check_mail")
      redirect_to root_url
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

  def following
    @title = "Following"
    @pagy, @users = pagy(@user.following, items: 10)
    render :show_follow
  end

  def followers
    @title = "Followers"
    @pagy, @users =pagy(@user.followers, items: 10)
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t("cannot_edit")
    redirect_to root_url
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
