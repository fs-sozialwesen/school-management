class RoomsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    authorize Room
    @rooms = Room.all
  end

  def new
    authorize Room
    @room = Room.new
  end

  def edit
  end

  def create
    authorize Room
    @room = Room.new room_params

    if @room.save
      redirect_to Room, notice: t(:created, model: Room.model_name.human)
    else
      render :new
    end
  end

  def update
    if @room.update room_params
      redirect_to Room, notice: t(:updated, model: Room.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to Room, notice: t(:destroyed, model: Room.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find params[:id]
    authorize @room
  end

  # Only allow a trusted parameter "white list" through.
  def room_params
    params.require(:room).permit(:name, :comments)
  end
end
