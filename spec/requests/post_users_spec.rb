require 'rails_helper'

RSpec.describe 'users post request', :type => :request do
  describe "create user request" do
    it "can make a user", :Vcr do
      user_data = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
      post '/api/v0/users', headers: {"CONTENT_TYPE" => "application/json"}, params: user_data.to_json

      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key(:data)
      expect(json[:data][:type]).to eq("users")
      expect(json[:data][:id].to_i).to be_a(Integer)
      expect(json[:data][:id].to_i).to eq(User.last.id)
      expect(json[:data][:attributes][:email]).to eq("whatever@example.com")
      expect(json[:data][:attributes][:api_key]).to be_a(String)
    end

    it "checks for unique email", :Vcr do
      User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")
      user_data = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
      post '/api/v0/users', headers: {"CONTENT_TYPE" => "application/json"}, params: user_data.to_json

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Email has already been taken")
    end

    it 'check for presense of fields', :Vcr do
      user_data = {
                    "email": "",
                    "password": "",
                    "password_confirmation": ""
                  }
      post '/api/v0/users', headers: {"CONTENT_TYPE" => "application/json"}, params: user_data.to_json

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Email can't be blank, Password can't be blank, Password can't be blank")
    end

    it 'checks matching passwords', :Vcr do
      user_data = {
                     "email": "hello@email.com",
                     "password": "123",
                     "password_confirmation": "000"
                  }
      post '/api/v0/users', headers: {"CONTENT_TYPE" => "application/json"}, params: user_data.to_json

      expect(response.status).to eq(422)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors].length).to eq(1)
      expect(json[:errors][0][:detail]).to eq("Error: Password confirmation doesn't match Password")
    end
  end
end