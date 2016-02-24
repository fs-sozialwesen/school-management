class LessonPolicy < ApplicationPolicy

  def copy?
    new?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
