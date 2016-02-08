<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"
<% end -%>
<% module_namespacing do -%>
class <%= controller_file_name.camelize %>Controller < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_<%= file_name %>, only: [:show, :edit, :update, :destroy]

  def index
    authorize <%= file_name.camelize %>
    @<%= plural_file_name %> = <%= file_name.camelize %>.all
  end

  def show
  end

  def new
    authorize <%= file_name.camelize %>
    @<%= file_name %> = <%= file_name.camelize %>.new
  end

  def edit
  end

  def create
    authorize <%= file_name.camelize %>
    @<%= file_name %> = <%= file_name.camelize %>.new <%= file_name %>_params

    if @<%= file_name %>.save
      redirect_to @<%= file_name %>, notice: t(:created, model: <%= file_name.camelize %>.model_name.human)
    else
      render :new
    end
  end

  def update
    if @<%= file_name %>.update <%= file_name %>_params
      redirect_to @<%= file_name %>, notice: t(:updated, model: <%= file_name.camelize %>.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @<%= file_name %>.destroy
    redirect_to <%= plural_table_name.downcase %>_url, notice: t(:destroyed, model: <%= file_name.camelize %>.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_<%= file_name %>
    @<%= file_name %> = <%= file_name.camelize %>.find params[:id]
    authorize @<%= file_name %>
  end

  # Only allow a trusted parameter "white list" through.
  def <%= file_name %>_params
    <%- if attributes_names.empty? -%>
    params[:<%= file_name %>]
    <%- else -%>
    params.require(:<%= singular_table_name.downcase %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
  end
end
<% end -%>
