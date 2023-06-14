require 'rails_helper'

RSpec.describe 'sessions post request', :type => :request do
  describe "create session request" do
    it "can log a user in", :Vcr do
      @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
      @user.generate_api_key
      login_data ={
                    "email": "whatever@example.com",
                    "password": "password"
                  }
      post '/api/v0/sessions', headers: {"CONTENT_TYPE" => "application/json"}, params: login_data.to_json

      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key(:data)
      expect(json[:data][:type]).to eq("users")
      expect(json[:data][:id].to_i).to be_a(Integer)
      expect(json[:data][:id].to_i).to eq(@user.id)
      expect(json[:data][:attributes][:email]).to be_a(String)
      expect(json[:data][:attributes][:email]).to eq(@user.email)
      expect(json[:data][:attributes][:api_key]).to be_a(String)
      expect(json[:data][:attributes][:api_key]).to eq(@user.api_key)
    end

    it 'provides nonspecific error for incorrect email', :Vcr do
      @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
      @user.generate_api_key
      login_data ={
                    "email": "bademail@example.com",
                    "password": "password"
                  }
      post '/api/v0/sessions', headers: {"CONTENT_TYPE" => "application/json"}, params: login_data.to_json

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Invalid email or password.")
    end

    it 'provides nonspecific error for incorrect password', :Vcr do
      @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
      @user.generate_api_key
      login_data ={
                    "email": "whatever@example.com",
                    "password": "badpassword"
                  }
      post '/api/v0/sessions', headers: {"CONTENT_TYPE" => "application/json"}, params: login_data.to_json

      expect(response.status).to eq(401)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Invalid email or password.")
    end
  end
end