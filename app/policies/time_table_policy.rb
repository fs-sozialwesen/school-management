class TimeTablePolicy < ApplicationPolicy

  def index?
    manager? or student? or teacher?
  end

  def show?
    manager? or (student? and time_table.course == student.course)
  end

  private

  def time_table
    record
  end

  class Scope < Scope
    def resolve
      return scope.where(course: user.as_student.course) if user.student?
      scope
    end
  end
end
