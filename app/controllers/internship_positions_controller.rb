class InternshipPositionsController < ApplicationController

  def index
    student = current_user.person
    @internship_positions = InternshipPosition.where(education_subject: student.education_subject, year: Date.today.year).all
  end

  def show
    @internship_position = InternshipPosition.find params[:id]
  end

end
