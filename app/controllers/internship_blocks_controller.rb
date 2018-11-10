class InternshipBlocksController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_internship_block, only: [:edit, :update, :destroy]

  def index
    authorize InternshipBlock
    @internship_blocks = InternshipBlock.order(:name).all
  end

  def new
    authorize InternshipBlock
    @internship_block = InternshipBlock.new
  end

  def edit
  end

  def create
    authorize InternshipBlock
    @internship_block = InternshipBlock.new internship_block_params

    if @internship_block.save
      redirect_to InternshipBlock, notice: t(:created, model: InternshipBlock.model_name.human)
    else
      render :new
    end
  end

  def update
    if @internship_block.update internship_block_params
      redirect_to InternshipBlock, notice: t(:updated, model: InternshipBlock.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @internship_block.destroy
    redirect_to InternshipBlock, notice: t(:destroyed, model: InternshipBlock.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_internship_block
    @internship_block = InternshipBlock.find params[:id]
    authorize @internship_block
  end

  # Only allow a trusted parameter "white list" through.
  def internship_block_params
    params.require(:internship_block).permit(:name, :course_year, :start_date, :end_date)
  end
end
