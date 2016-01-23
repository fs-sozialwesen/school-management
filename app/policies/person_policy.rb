class PersonPolicy < ApplicationPolicy

  def index?
    user.manager?
  end

  def show?
    user.manager? or user == record
  end

  alias :edit? :show?
  alias :update? :show?
  alias :new? :index?
  alias :create? :index?
  alias :destroy? :index?


  class Scope < Scope
    def resolve
      scope
    end
  end
end
