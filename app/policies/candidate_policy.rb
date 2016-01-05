class CandidatePolicy < ApplicationPolicy

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

  def init?
    index?
  end

  def approve?
    index?
  end

  def invite?
    index?
  end

  def interview?
    index?
  end

  def accept?
    index?
  end

  def reject?
    index?
  end

  def cancel?
    index?
  end


  class Scope < Scope
    def resolve
      scope
    end
  end
end
