module Timetable
  class TimeBlocksController < ApplicationController
    before_action :authenticate_login!
    after_action :verify_authorized
    before_action :set_time_block, only: [:show, :edit, :update, :destroy]

    def index
      authorize TimeBlock
      @time_blocks = TimeBlock.order(:start_time).all
    end

    def show
    end

    def new
      authorize TimeBlock
      @time_block = TimeBlock.new
    end

    def edit
    end

    def create
      authorize TimeBlock
      # binding.pry
      @time_block = TimeBlock.new time_block_params

      if @time_block.save
        redirect_to @time_block, notice: t(:created, model: TimeBlock.model_name.human)
      else
        render :new
      end
    end

    def update
      if @time_block.update time_block_params
        redirect_to @time_block, notice: t(:updated, model: TimeBlock.model_name.human)
      else
        render :edit
      end
    end

    def destroy
      @time_block.destroy
      redirect_to timetable_time_blocks_url, notice: t(:destroyed, model: TimeBlock.model_name.human)
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_time_block
      @time_block = TimeBlock.find params[:id]
      authorize @time_block
    end

    # Only allow a trusted parameter "white list" through.
    def time_block_params
      params.require(:timetable_time_block).permit(:start_time, :end_time)
    end
  end
end
