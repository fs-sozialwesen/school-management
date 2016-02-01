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
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def contact_params
    [ address: %i(street zip city), contact: %i(email phone mobile) ]
  end

  def person_params
    %i(first_name last_name gender date_of_birth place_of_birth) + contact_params
  end

  def after_sign_in_path_for(login)
    return root_path if login.sign_in_count > 1
    edit_login_registration_url(login)
  end
end
