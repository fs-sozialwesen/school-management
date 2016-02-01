class LoginPolicy
  attr_reader :current_user, :login

  def initialize(current_user, login)
    @current_user = current_user
    @login = login
  end

  def index?
    @current_user.manager?
  end

  def show?
    @current_user.manager? or @current_user.login == @login
  end

  alias :update? :index?
  alias :new? :index?
  alias :create? :index?
  alias :toggle? :index?

  def destroy?
    return false if @current_user.login == @login
    @current_user.admin? or @current_user.manager?
  end

end
