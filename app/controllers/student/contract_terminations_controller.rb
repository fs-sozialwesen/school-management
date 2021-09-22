class Student::ContractTerminationsController < ApplicationController
  def new
    @student = Student.find params[:student_id]
    @contract_termination = @student.build_contract_termination
  end

  def create
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
