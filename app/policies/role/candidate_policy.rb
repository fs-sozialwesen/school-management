class Role::CandidatePolicy < ApplicationPolicy

  def index?
    user.manager?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
