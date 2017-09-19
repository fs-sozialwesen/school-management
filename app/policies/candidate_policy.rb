class CandidatePolicy < ApplicationPolicy

  def accept?
    manager?
  end

  def reject?
    manager?
  end

end
