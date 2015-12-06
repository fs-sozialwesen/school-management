class Contract < ActiveRecord::Base
  belongs_to :role
  belongs_to :first_party,  polymorphic: true
  belongs_to :second_party, polymorphic: true

  rails_admin do
    navigation_label I18n.t(:basic_data)

  end
end
