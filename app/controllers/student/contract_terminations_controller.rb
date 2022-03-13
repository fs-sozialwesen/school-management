class Student::ContractTerminationsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def new
    authorize Student, :terminate_contract?
    @student = Student.find params[:student_id]
    @contract_termination = @student.build_contract_termination
  end

  def create
    authorize Student, :terminate_contract?
    @student = Student.find params[:student_id]
    @contract_termination = @student.build_contract_termination(
      params.require(:student_contract_termination).permit(:date, :notes, :terminated_by)
    )
    if @contract_termination.save
      @student.update active: false
      redirect_to @student, notice: t(:created, model: Student.model_name.human)
    else
      render :new
    end
  end
end
