class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params.dig(:session, :email)&.downcase
    if user&.authenticate params.dig(:session, :password)
      if user.activated
        log_in user
        if params.dig(:session,
                      :remember_me) == "1"
          remember user
        else
          forget user
        end
        redirect_back_or user
      else
        flash[:warming] = t("account_not_activated")
        redirect_to root_url
      end
    else
      flash.now[:danger] = t("result_login")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
