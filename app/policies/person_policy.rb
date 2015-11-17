class PersonPolicy < ApplicationPolicy

  def show?
    user.admin? or user == record
  end

  def edit?
    show?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
