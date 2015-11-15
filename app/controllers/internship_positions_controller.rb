class InternshipPositionsController < ApplicationController

  def index
    student = current_user.as_student
    @internship_positions = InternshipPosition.
      includes(internship_offer: :organisation).
      where(
        education_subject: student.education_subject
      ).
      all
  end

  def show
    @internship_position = InternshipPosition.find params[:id]
    @internship_offer = @internship_position.internship_offer
  end

end
