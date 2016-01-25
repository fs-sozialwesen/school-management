describe LoginPolicy do
  subject { LoginPolicy }

  let (:current_login) { FactoryGirl.build_stubbed :login }
  let (:current_user)  { current_login.build_person }
  let (:other_login) { FactoryGirl.build_stubbed :login }
  let (:manager_login) { FactoryGirl.build_stubbed :login }
  let (:manager_user) do
    p = manager_login.build_person
    p.create_as_manager
    p
  end

  permissions :index? do
    it "denies access if not an manager" do
      expect(LoginPolicy).not_to permit(current_login.build_person)
    end
    it "allows access for an manager" do
      # manager.build_person.build_as_manager.save
      expect(LoginPolicy).to permit(manager_user)
    end
  end

  permissions :show? do
    it "prevents other logins from seeing your profile" do
      expect(subject).not_to permit(current_user, other_login)
    end
    it "allows you to see your own profile" do
      expect(subject).to permit(current_user, current_login)
    end
    it "allows an manager to see any profile" do
      expect(subject).to permit(manager_user)
    end
  end

  permissions :update? do
    it "prevents updates if not an manager" do
      expect(subject).not_to permit(current_user)
    end
    it "allows an manager to make updates" do
      expect(subject).to permit(manager_user)
    end
  end

  permissions :destroy? do
    it "prevents deleting yourself" do
      expect(subject).not_to permit(current_user, current_login)
    end
    it "allows an manager to delete any login" do
      expect(subject).to permit(manager_user, other_login)
    end
  end

end
