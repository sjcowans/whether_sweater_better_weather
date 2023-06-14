require 'rails_helper'

RSpec.describe ForecastService do
  it 'can return coordinates', :vcr do
    coordinates = MapquestService.city_coordinates('El Paso, Tx')

    expect(coordinates).to be_a(Hash)
    expect(coordinates[:results]).to be_an(Array)
    expect(coordinates[:results].length).to eq(1)
    expect(coordinates[:results][0][:locations]).to be_an(Array)
    expect(coordinates[:results][0][:locations][0]).to be_a(Hash)
    expect(coordinates[:results][0][:locations][0][:latLng]).to be_a(Hash)
    expect(coordinates[:results][0][:locations][0][:latLng][:lat]).to eq(31.75916)
    expect(coordinates[:results][0][:locations][0][:latLng][:lng]).to eq(-106.48749)
  end

  it 'can return travel time', :vcr do
    time = MapquestService.travel_time('El Paso, Tx', 'New York, NY')

    expect(time).to be_a(Hash)
    expect(time[:route]).to be_a(Hash)
    expect(time[:route][:formattedTime]).to be_a(String)
  end
end