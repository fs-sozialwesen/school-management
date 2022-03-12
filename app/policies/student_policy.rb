class StudentPolicy < ApplicationPolicy

  def terminate_contract?
    manager?
  end

end
