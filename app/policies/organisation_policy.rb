class OrganisationPolicy < ApplicationPolicy

  def index?
    manager? || intern_manager?
  end

  def show?
    index?
  end

  def update?
    manager? || intern_manager?
  end

end
