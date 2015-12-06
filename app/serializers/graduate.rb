class Graduate < JsonSerializer
  attribute :type,       String
  attribute :name,       String
  attribute :graduate,   String
  attribute :comments,   String
  attribute :proved,     Boolean, default: false
  attribute :address,    String
  # attribute :start_date, Date
  # attribute :end_date,   Date

end
