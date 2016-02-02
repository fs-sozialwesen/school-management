class ManagerPolicy < ApplicationPolicy

  def destroy?
    user.manager? && user != record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
