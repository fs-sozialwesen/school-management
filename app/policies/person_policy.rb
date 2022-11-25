class PersonPolicy < ApplicationPolicy

  def employees?
    manager?
  end

  def managers?
    manager?
  end

  def teachers?
    manager?
  end

  def students?
    manager?
  end

  def mentors?
    manager? or intern_manager?
  end

  def show?
    manager? or (intern_manager? && person.mentor?) or user == person
  end

  alias :edit? :show?
  alias :update? :show?

  def create?
    manager? or intern_manager?
  end

  def destroy?
    if record.manager?
      # don't let managers delete them self
      manager? && user != person
    else
      manager?
    end
  end
  alias :toggle_archived? :destroy?

  def add_role?
    manager?
  end
  alias :toggle_intern_manager? :add_role?

  def person
    record
  end


  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
