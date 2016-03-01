class TimeBlocksController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_time_block, only: [:edit, :update, :destroy]

  def index
    authorize TimeBlock
    @time_blocks = TimeBlock.all
  end

  def new
    authorize TimeBlock
    @time_block = TimeBlock.new
  end

  def edit
  end

  def create
    authorize TimeBlock
    @time_block = TimeBlock.new time_block_params

    if @time_block.save
      redirect_to TimeBlock, notice: t(:created, model: TimeBlock.model_name.human)
    else
      render :new
    end
  end

  def update
    if @time_block.update time_block_params
      redirect_to TimeBlock, notice: t(:updated, model: TimeBlock.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @time_block.destroy
    redirect_to TimeBlock, notice: t(:destroyed, model: TimeBlock.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_time_block
    @time_block = TimeBlock.find params[:id]
    authorize @time_block
  end

  # Only allow a trusted parameter "white list" through.
  def time_block_params
    params.require(:time_block).permit(:start_time, :end_time)
  end
end
