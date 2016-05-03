class Graduate < JsonSerializer
  attribute :graduate,   String
  attribute :comments,   String
  attribute :proved,     Boolean, default: false
  
  def complete?
    graduate.blank? || proved
  end
end
