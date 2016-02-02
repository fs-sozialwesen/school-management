class PersonPolicy < ApplicationPolicy

  def managers?
    manager?
  end

  def teachers?
    manager?
  end

  def students?
    manager?
  end

  def show?
    manager? or user == person
  end

  alias :edit? :show?
  alias :update? :show?

  def destroy?
    if record.manager?
      # don't let managers delete them self
      manager? && user != person
    else
      manager?
    end
  end

  def person
    record
  end


  class Scope < Scope
    def resolve
      scope
    end
  end
end
