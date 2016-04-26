class EnumsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize Enum
    @enum_types = Enum::TYPES.sort
  end

  def edit
    authorize Enum
    @enum_name = params[:id]
    @enums = Enum.send @enum_name.pluralize
  end

  def update
    authorize Enum
    @enum_name = params[:id]
    values = params[:enum]['values'].split "\r\n"
    Enum.replace @enum_name, values
    redirect_to enums_url
  end
end
