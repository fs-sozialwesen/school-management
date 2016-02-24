require 'rails_helper'

describe TimeBlockPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
  end

end
