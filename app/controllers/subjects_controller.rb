class SubjectsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  def index
    authorize Subject
    @subjects = Subject.all
  end

  def show
  end

  def new
    authorize Subject
    @subject = Subject.new
  end

  def edit
  end

  def create
    authorize Subject
    @subject = Subject.new subject_params

    if @subject.save
      redirect_to @subject, notice: t(:created, model: Subject.model_name.human)
    else
      render :new
    end
  end

  def update
    if @subject.update subject_params
      redirect_to @subject, notice: t(:updated, model: Subject.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    redirect_to subjects_url, notice: t(:destroyed, model: Subject.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subject
    @subject = Subject.find params[:id]
    authorize @subject
  end

  # Only allow a trusted parameter "white list" through.
  def subject_params
    params.require(:subject).permit(:name, :comments)
  end
end
