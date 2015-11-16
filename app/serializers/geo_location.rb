class GeoLocation
  include Virtus.value_object

  values do
    attribute :lat,  Float
    attribute :lng, Float
  end
end
