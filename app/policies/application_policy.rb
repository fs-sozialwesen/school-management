class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    manager?
  end

  def show?
    manager?
  end

  def create?
    manager?
  end

  def new?
    create?
  end

  def update?
    manager?
  end

  def edit?
    update?
  end

  def destroy?
    manager?
  end

  # def scope
  #   Pundit.policy_scope!(user, record.class)
  # end

  def manager?
    user.manager?
  end

  def teacher?
    user.teacher?
  end

  # def employee?
  #   user.employee?
  # end

  def student?
    user.student?
  end

  def manager
    manager? && user.as_manager
  end

  def teacher
    teacher? && user.as_teacher
  end

  # def student
  #   student? && user.as_student
  # end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
