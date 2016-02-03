class CoursePolicy < ApplicationPolicy

  def generate_logins?
    user.manager?
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
