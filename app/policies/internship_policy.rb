class InternshipPolicy < ApplicationPolicy

  def index?
    manager? || intern_manager?
  end

  def create?
    manager? || intern_manager?
  end

  def copy?
    create?
  end

  def report?
    index?
  end

  def export?
    index?
  end
end
