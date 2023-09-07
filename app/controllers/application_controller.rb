class ApplicationController < ActionController::Base
  include SessionHelper
  include Pagy::Backend
  around_action :set_locale

  private

  def set_locale &action
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t("please_log_in")
    store_location
    redirect_to login_url
  end
end
