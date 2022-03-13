class Student::ContractTermination < ActiveRecord::Base
  belongs_to :student, inverse_of: :contract_termination

  validates :date, presence: true
end
