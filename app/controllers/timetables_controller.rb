class TimetablesController < ApplicationController
  def index
    redirect_to action: :show, id: Date.today
  end

  def show
    @this_week = Date.today
    @last_week = @this_week - 7
    @next_week = @this_week + 7

    @date = Date.parse params[:id]
    has_lessons = if params[:room_name].present?
      Room.find_by(name: params[:room_name])
    else
      case current_user.person
      when Student then current_user.person.course
      when Teacher then current_user.person
      end
    end

    @timetable = Timetable.new has_lessons, @date
  end
end
