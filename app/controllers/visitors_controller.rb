class VisitorsController < ApplicationController

  def index
    redirect_to new_login_session_path unless login_signed_in?
  end
end
