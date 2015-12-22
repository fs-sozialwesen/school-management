# TimetablesController
class TimetablesController < ApplicationController
  def index
    redirect_to action: :show, id: Date.current
  end

  def show
    @date      = Date.parse params[:id]
    @timetable = Timetable.new something_with_lessons, @date
  end

  private

  def something_with_lessons
    params[:room_name].present? ? Room.find_by(name: params[:room_name]) : person_timetable
  end

  def person_timetable
    case current_user.person
    when Student then current_user.person.course
    when Teacher then current_user.person
    end
  end

  def this_week
    Date.current
  end

  def last_week
    this_week - 7
  end

  def next_week
    this_week + 7
  end
end
