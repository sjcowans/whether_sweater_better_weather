require 'rails_helper'

RSpec.describe ForecastService do
  it 'can return a forecast', :vcr do
    weather = ForecastService.city_forecast('30', '30')
    
    expect(weather[:current]).to be_a(Hash)
    expect(weather[:current][:last_updated]).to be_a(String)
    expect(weather[:current][:temp_f]).to be_a(Float)
    expect(weather[:current][:feelslike_f]).to be_a(Float)
    expect(weather[:current][:humidity]).to be_a(Integer)
    expect(weather[:current][:uv]).to be_a(Float)
    expect(weather[:current][:vis_miles]).to be_a(Float)
    expect(weather[:current][:condition]).to be_a(Hash)
    expect(weather[:current][:condition][:text]).to be_a(String)

    expect(weather[:forecast]).to be_a(Hash)
    expect(weather[:forecast][:forecastday]).to be_an(Array)
    expect(weather[:forecast][:forecastday].count).to eq(5)
    expect(weather[:forecast][:forecastday][0]).to be_a(Hash)
    expect(weather[:forecast][:forecastday][0][:date]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:astro]).to be_a(Hash)
    expect(weather[:forecast][:forecastday][0][:astro][:sunrise]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:astro][:sunset]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:day][:maxtemp_f]).to be_a(Float)
    expect(weather[:forecast][:forecastday][0][:day][:mintemp_f]).to be_a(Float)
    expect(weather[:forecast][:forecastday][0][:day][:condition][:text]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:day][:condition][:icon]).to be_a(String)

    expect(weather[:forecast][:forecastday][0][:hour]).to be_an(Array)
    expect(weather[:forecast][:forecastday][0][:hour].count).to eq(24)
    expect(weather[:forecast][:forecastday][0][:hour][0][:time]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:hour][0][:temp_f]).to be_a(Float)
    expect(weather[:forecast][:forecastday][0][:hour][0][:condition]).to be_a(Hash)
    expect(weather[:forecast][:forecastday][0][:hour][0][:condition][:text]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:hour][0][:condition][:icon]).to be_a(String)
  end

  it 'can return a forecast with specific time', :vcr do
    weather = ForecastService.city_time_forecast('30', '30', '2023-21-08', '08')
    
    expect(weather[:current]).to be_a(Hash)
    expect(weather[:current][:last_updated]).to be_a(String)
    expect(weather[:current][:temp_f]).to be_a(Float)
    expect(weather[:current][:feelslike_f]).to be_a(Float)
    expect(weather[:current][:humidity]).to be_a(Integer)
    expect(weather[:current][:uv]).to be_a(Float)
    expect(weather[:current][:vis_miles]).to be_a(Float)
    expect(weather[:current][:condition]).to be_a(Hash)
    expect(weather[:current][:condition][:text]).to be_a(String)

    expect(weather[:forecast]).to be_a(Hash)
    expect(weather[:forecast][:forecastday]).to be_an(Array)
    expect(weather[:forecast][:forecastday].count).to eq(1)
    expect(weather[:forecast][:forecastday][0]).to be_a(Hash)
    expect(weather[:forecast][:forecastday][0][:date]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:astro]).to be_a(Hash)
    expect(weather[:forecast][:forecastday][0][:astro][:sunrise]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:astro][:sunset]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:day][:maxtemp_f]).to be_a(Float)
    expect(weather[:forecast][:forecastday][0][:day][:mintemp_f]).to be_a(Float)
    expect(weather[:forecast][:forecastday][0][:day][:condition][:text]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:day][:condition][:icon]).to be_a(String)

    expect(weather[:forecast][:forecastday][0][:hour]).to be_an(Array)
    expect(weather[:forecast][:forecastday][0][:hour].count).to eq(1)
    expect(weather[:forecast][:forecastday][0][:hour][0][:time]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:hour][0][:temp_f]).to be_a(Float)
    expect(weather[:forecast][:forecastday][0][:hour][0][:condition]).to be_a(Hash)
    expect(weather[:forecast][:forecastday][0][:hour][0][:condition][:text]).to be_a(String)
    expect(weather[:forecast][:forecastday][0][:hour][0][:condition][:icon]).to be_a(String)
  end
end