describe Login do

  before(:each) { @login = Login.new(email: 'user@example.com') }

  subject { @login }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@login.email).to match 'user@example.com'
  end

end
