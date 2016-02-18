class TimeTablePolicy < ApplicationPolicy

  def index?
    manager? or student? or teacher?
  end

  def show?
    manager? or
      (student? and time_table.course == student.course) or
      (teacher?)
  end

  def toggle?
    manager?
  end

  private

  def time_table
    record
  end

  class Scope < Scope
    def resolve
      return scope.active.where(course: user.as_student.course) if user.student?
      return scope.active.where(id: user.as_teacher.time_tables) if user.teacher?
      scope
    end
  end
end
