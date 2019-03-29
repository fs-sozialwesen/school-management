class InternshipBlockPolicy < ApplicationPolicy

  def index?
    manager? || intern_manager?
  end

  def show?
    manager? || intern_manager?
  end

  def create?
    manager? || intern_manager?
  end

  def update?
    manager? || intern_manager?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
