class LessonPolicy < ApplicationPolicy

  def copy?
    new?
  end
end
