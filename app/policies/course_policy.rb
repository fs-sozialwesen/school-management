class CoursePolicy < ApplicationPolicy

  def index?
    manager? || intern_manager?
  end

  def show?
    manager? || intern_manager?
  end

  def reset_db_id?
    true
  end

  def generate_logins?
    user.manager?
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
