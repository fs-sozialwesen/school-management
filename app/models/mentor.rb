class Mentor < ActiveRecord::Base
  belongs_to :person # remove after deployment, needed for migration
  belongs_to :organisation, required: true, inverse_of: :mentors
  has_many :internships

  scope :active,   -> { where.not archived: true }
  scope :archived, -> { where archived: true }

  acts_as_addressable
  acts_as_contactable

  validates :first_name, :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end

end
