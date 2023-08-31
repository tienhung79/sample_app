class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @pagy, @feed_items = pagy current_user.feed, items: Settings.digits.number_of_page
    end
  end

  def help; end
end
