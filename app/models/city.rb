class City < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude
end
