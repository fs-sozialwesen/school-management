class InternshipPolicy < ApplicationPolicy
  def copy?
    create?
  end
end
