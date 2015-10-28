class Address
  attr_accessor :street, :city, :zip

  def initialize(street, city, zip)
    @street = street
    @city   = city
    @zip    = zip
  end

  def ==(other)
    street == other.street && city == other.city && zip == other.zip
  end
end
