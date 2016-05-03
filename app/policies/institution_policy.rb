class InstitutionPolicy < ApplicationPolicy
  def index?
    manager? or student?
  end

  def show?
    index?
  end
end
