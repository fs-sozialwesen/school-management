class LoginPolicy
  attr_reader :current_user, :login

  def initialize(current_user, login)
    @current_user = current_user
    @login = login
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? or @current_user.manager? or @current_user.login == @login
  end

  def update?
    @current_user.admin? or @current_user.manager?
  end

  def destroy?
    return false if @current_user.login == @login
    @current_user.admin? or @current_user.manager?
  end

end
