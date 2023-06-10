class City < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude

  def self.new_city(params, coordinates)
    city = City.new(name: params[:location], longitude: coordinates[:lng],  latitude: coordinates[:lat])
    city.save
    city
  end
end
