require 'rails_helper'

RSpec.describe 'post roadtrip request', :type => :request do
  describe "post roadtrip request", :vcr do
    it "can make a roatrip", :Vcr do
      @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      trip_data ={
                    "origin": "Cincinatti,OH",
                    "destination": "Chicago,IL",
                    "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                  }
      post '/api/v0/road_trip', headers: {"CONTENT_TYPE" => "application/json"}, params: trip_data.to_json

      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key(:data)
      expect(json[:data][:type]).to eq("road_trip")
      expect(json[:data][:id]).to eq('null')
      expect(json[:data][:attributes].keys.count).to eq(4)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:start_city]).to eq("Cincinatti,OH")
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to eq("Chicago,IL")
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json[:data][:attributes][:weather_at_eta].keys.count).to eq(3)
      expect(json[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(json[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
    end

    it "checks api key", :Vcr do
      @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      trip_data ={
                    "origin": "Cincinatti,OH",
                    "destination": "Chicago,IL",
                    "api_key": "wrong key"
                  }
      post '/api/v0/road_trip', headers: {"CONTENT_TYPE" => "application/json"}, params: trip_data.to_json

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Invalid API key")
    end

    it 'will give improper location errors', :Vcr do
      @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      trip_data ={
                    "origin": "",
                    "destination": "Chicago,IL",
                    "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                  }
      post '/api/v0/road_trip', headers: {"CONTENT_TYPE" => "application/json"}, params: trip_data.to_json

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Invalid destination or location")

      trip_data ={
                    "origin": "Chicago,IL",
                    "destination": "",
                    "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                  }
      post '/api/v0/road_trip', headers: {"CONTENT_TYPE" => "application/json"}, params: trip_data.to_json

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Invalid destination or location")
    end

    it 'can give impossible route', :Vcr do
      @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password", api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      trip_data ={
                    "origin": "New York, NY",
                    "destination": "London, UK",
                    "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
                  }
      post '/api/v0/road_trip', headers: {"CONTENT_TYPE" => "application/json"}, params: trip_data.to_json

      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key(:data)
      expect(json[:data][:type]).to eq("road_trip")
      expect(json[:data][:id]).to eq('null')
      expect(json[:data][:attributes].keys.count).to eq(4)
      expect(json[:data][:attributes][:start_city]).to be_a(String)
      expect(json[:data][:attributes][:start_city]).to eq("New York, NY")
      expect(json[:data][:attributes][:end_city]).to be_a(String)
      expect(json[:data][:attributes][:end_city]).to eq("London, UK")
      expect(json[:data][:attributes][:travel_time]).to be_a(String)
      expect(json[:data][:attributes][:travel_time]).to eq("Impossible")
      expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(json[:data][:attributes][:weather_at_eta].keys.count).to eq(3)
      expect(json[:data][:attributes][:weather_at_eta][:datetime]).to eq("")
      expect(json[:data][:attributes][:weather_at_eta][:temperature]).to eq("")
      expect(json[:data][:attributes][:weather_at_eta][:condition]).to eq("")
    end
  end
end
