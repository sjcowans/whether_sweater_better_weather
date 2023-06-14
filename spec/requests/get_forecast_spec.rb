
require 'rails_helper'

RSpec.describe 'forecast requests', type: :request do
  describe 'get forecast' do
    it 'can get forecast for a city', :vcr do

      get '/api/v0/forecast?location=cincinatti,oh'

      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:data][:id]).to eq('null')
      expect(data[:data][:type]).to eq"forecast"
      expect(data[:data][:attributes][:current_weather][:last_updated]).to be_a(String)
      expect(data[:data][:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(data[:data][:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(data[:data][:attributes][:current_weather][:humidity]).to be_an(Integer)
      expect(data[:data][:attributes][:current_weather][:uvi]).to be_a(Float)
      expect(data[:data][:attributes][:current_weather][:visibility]).to be_a(Float)
      expect(data[:data][:attributes][:current_weather][:condition]).to be_a(String)
      expect(data[:data][:attributes][:current_weather][:icon]).to be_a(String)
      expect(data[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(data[:data][:attributes][:daily_weather].length).to eq(5)
      data[:data][:attributes][:daily_weather].each do |day|
        expect(day[:date]).to be_a(String)
        expect(day[:sunrise]).to be_a(String)
        expect(day[:sunset]).to be_a(String)
        expect(day[:max_temp]).to be_an(Float)
        expect(day[:min_temp]).to be_an(Float)
        expect(day[:condition]).to be_a(String)
        expect(day[:icon]).to be_a(String)
      end
      expect(data[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(data[:data][:attributes][:hourly_weather].length).to eq(120)
      data[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour[:time]).to be_a(String)
        expect(hour[:temperature]).to be_an(Float)
        expect(hour[:conditions]).to be_a(String)
        expect(hour[:icon]).to be_a(String)
      end
    end

    it 'checks for correct city', :vcr do
      get '/api/v0/forecast?location='

      expect(response.status).to eq(422)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: No coordinates for city found")
    end
  end
end