class InternshipPositionPolicy < ApplicationPolicy

  def index?
    manager? or student?
  end

  def show?
    index?
  end

  class Scope < Scope
    def resolve
      # return scope.where(education_subject: user.as_student.education_subject) if user.student?
      scope
    end
  end
end
