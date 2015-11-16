class AccommodationOptions < JsonSerializer

  attribute :possible,  Boolean, default: false
  attribute :costs,  String

  def self.possible;      { possible: true  }.to_json; end
  def self.not_possible;  { possible: false  }.to_json; end

end
