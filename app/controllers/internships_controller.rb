class InternshipsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_internship, only: [:show, :edit, :update, :destroy, :copy]

  def index
    authorize Internship
    @internships = Internship.includes(student: :course, institution: :organisation).order('students.last_name')
    @block = InternshipBlock.find_by id: params[:block_id]
    @course = Course.find_by(id: params[:course_id]) || Course.order(end_date: :desc).active.first
    @internships = @internships.where(internship_block: @block, student_id: @course.students.select(:id))

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def report
    authorize Internship
    internships = Internship.
      joins(:internship_block, institution: :organisation).
      order('organisations.name', 'internship_blocks.course_year').
      group('internship_blocks.course_year', 'organisations.name').
      where('internship_blocks.course_year > 2015').
      count
    @years = internships.keys.map(&:first).uniq.compact.sort
    @internships = {}
    internships.each { |(year, name), number| (@internships[name] ||= {})[year] = number  }

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def show
  end

  def new
    authorize Internship
    student     = Student.find params[:student_id]
    block       = InternshipBlock.find params[:block_id]
    @internship = Internship.new student: student, internship_block: block
    @students   = Student.order(:first_name, :last_name)
  end

  def edit
  end

  def create
    authorize Internship
    @internship = Internship.new internship_params

    if @internship.save
      redirect_to @internship.student.course, notice: t(:created, model: Internship.model_name.human)
    else
      render :new
    end
  end

  def update
    if @internship.update internship_params
      redirect_to @internship.student.course, notice: t(:updated, model: Internship.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @internship.destroy
    redirect_to @internship.student.course, notice: t(:destroyed, model: Internship.model_name.human)
  end

  def copy
    @existing_internship = @internship
    @internship = Internship.new @existing_internship.attributes.except 'id'
    render :new
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_internship
    @internship = Internship.find params[:id]
    authorize @internship
  end

  # Only allow a trusted parameter "white list" through.
  def internship_params
    params[:internship].delete :organisation
    params.require(:internship).permit(
      :student_id, :institution_id, :mentor_id, :internship_block_id, :contract_proved, :comments, :exchange
    )
  end

end
