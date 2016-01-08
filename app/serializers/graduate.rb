class Graduate < JsonSerializer
  attribute :graduate,   String
  attribute :comments,   String
  attribute :proved,     Boolean, default: false
  
  def complete?
    return true if graduate.blank?
    proved
  end
end
