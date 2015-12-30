class InternshipPositionPolicy < ApplicationPolicy

  def index?
    @user.manager? or user.student?
  end

  def show?
    # @user.manager? or (user.student? and user.as_student.education_subject == record.education_subject)
    index?
  end

  class Scope < Scope
    def resolve
      # return scope.where(education_subject: user.as_student.education_subject) if user.student?
      scope
    end
  end
end
