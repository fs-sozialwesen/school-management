class InstitutionPolicy < ApplicationPolicy
  def index?
    manager? or student? or intern_manager?
  end

  def show?
    index?
  end

  def update?
    manager? || intern_manager?
  end
end
