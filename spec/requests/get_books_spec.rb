
require 'rails_helper'

RSpec.describe 'books requests', type: :request do
  describe 'get books' do
    it 'can get books for a city' do

      get '/api/v1/book-search?location=denver,co&quantity=5'

      binding.pry
      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names: true)
    end
  end
end