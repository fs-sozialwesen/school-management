class Position < JsonSerializer

  attribute :education_subject_id, Integer
  attribute :count,                Integer, default: 1

  attribute :address,  Address
  attribute :contact,  Contact
  attribute :housing,  Housing
  attribute :applying, Applying
end
