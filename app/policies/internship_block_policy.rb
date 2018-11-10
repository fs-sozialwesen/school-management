class InternshipBlockPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
end
