class CitySerializer
  include JSONAPI::Serializer
  attributes :name, :latitude, :longitude
end