class User < ActiveRecord::Base
  enum role: { user: 0, admin: 1, student: 2, teacher: 3 }
  after_initialize :set_default_role, if: :new_record?

  has_one :person, inverse_of: :user

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  rails_admin do
    navigation_label I18n.t(:basic_data)
    weight +20

    list do
      # include_all_fields
      # exclude_fields %i(encrypted_password reset_password_token reset_password_sent_at
      #     remember_created_at sign_in_count current_sign_in_ip last_sign_in_ip
      #     confirmation_token confirmation_sent_at unconfirmed_email)
      field(:email, :email)
      field :person
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end

    show do
      field :name
      include_all_fields
      field(:email, :email)
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end
  end

end
