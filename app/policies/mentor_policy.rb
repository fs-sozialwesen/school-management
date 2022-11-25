class MentorPolicy < ApplicationPolicy
  def index?
    manager? or intern_manager?
  end

  def show?
    manager? or intern_manager?
  end

  def create?
    manager? or intern_manager?
  end

  def update?
    manager? or intern_manager?
  end

  def toggle_archived?
    manager? or intern_manager?
  end
end
