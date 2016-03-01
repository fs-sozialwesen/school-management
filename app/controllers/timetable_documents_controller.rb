class TimetableDocumentsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_timetable_document, only: [:edit, :update, :destroy]

  def index
    authorize TimetableDocument
    @timetable_documents = TimetableDocument.all
  end

  def new
    authorize TimetableDocument
    @years = Course.active.map {|c| c.start_date.year }.uniq.sort
    @timetable_document = TimetableDocument.new
  end

  def edit
    @years = Course.active.map {|c| c.start_date.year }.uniq.sort
  end

  def create
    authorize TimetableDocument
    @timetable_document = TimetableDocument.new timetable_document_params

    if @timetable_document.save
      redirect_to TimetableDocument, notice: t(:created, model: TimetableDocument.model_name.human)
    else
      render :new
    end
  end

  def update
    if @timetable_document.update timetable_document_params
      redirect_to TimetableDocument, notice: t(:updated, model: TimetableDocument.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @timetable_document.destroy
    redirect_to timetable_documents_url, notice: t(:destroyed, model: TimetableDocument.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_timetable_document
    @timetable_document = TimetableDocument.find params[:id]
    authorize @timetable_document
  end

  # Only allow a trusted parameter "white list" through.
  def timetable_document_params
    params.require(:timetable_document).permit(:name, :start_date, :end_date, :year, :document)
  end
end
