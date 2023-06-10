
require 'rails_helper'

RSpec.describe 'coordiantes requests', type: :request do
  describe 'get coordinates' do
    it 'can get coordinates for a city' do

      get '/api/v0/forecast?location=cincinatti,oh'

      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:data][:id]).to eq(City.last.id.to_s)
      expect(data[:data][:type]).to eq("city")
      expect(data[:data][:attributes][:name]).to eq("cincinatti,oh")
      expect(data[:data][:attributes][:longitude]).to eq(-84.50413)
      expect(data[:data][:attributes][:latitude]).to eq(39.10713)
    end
  end
end