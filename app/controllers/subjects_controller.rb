class SubjectsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    authorize Subject
    @subjects = Subject.order(:name).all
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
      redirect_to Subject, notice: t(:created, model: Subject.model_name.human)
    else
      render :new
    end
  end

  def update
    if @subject.update subject_params
      redirect_to Subject, notice: t(:updated, model: Subject.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      redirect_to Subject, notice: t(:destroyed, model: Subject.model_name.human)
    else
      redirect_to edit_subject_url(@subject), flash: { error: @subject.errors.full_messages.join(' ') }
    end
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
