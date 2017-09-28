describe LoginPolicy do
  subject { LoginPolicy }

  let (:current_user)  { build :person }
  let (:other_login)   { build :login }
  let((:manager_user)) { build :person, :as_manager }

  permissions :destroy? do
    specify { expect(subject).not_to permit(current_user, current_user.login) }
    specify { expect(subject).to     permit(manager_user, other_login) }
  end

end
