class CandidatePolicy < ApplicationPolicy

  def accept?
    manager?
  end

  def reject?
    manager?
  end

  # class Scope < Scope
  #   def resolve
  #     scope
  #   end
  # end
end
