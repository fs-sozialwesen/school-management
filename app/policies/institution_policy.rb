class InstitutionPolicy < ApplicationPolicy
  def index?
    manager? or student?
  end

  def show?
    index?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
