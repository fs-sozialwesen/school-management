class TeacherPolicy < ApplicationPolicy

  def index?
    user.manager?
  end

  alias :show? :index?
  alias :edit? :index?
  alias :update? :index?
  alias :new? :index?
  alias :create? :index?
  alias :destroy? :index?

  class Scope < Scope
    def resolve
      scope
    end
  end
end
