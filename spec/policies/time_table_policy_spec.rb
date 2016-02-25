require 'rails_helper'

describe TimeTablePolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
  end

end
