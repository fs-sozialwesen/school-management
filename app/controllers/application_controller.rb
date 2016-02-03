class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    current_login && current_login.person
  end

  def user_not_authorized
    flash[:alert] = "Du bist nicht berechtigt, diese Seite zu sehen."
    redirect_to (request.referrer || root_path)
  end

  def after_sign_in_path_for(login)
    return edit_login_registration_url(login) unless login.sign_in_count > 1
    super
  end
end
