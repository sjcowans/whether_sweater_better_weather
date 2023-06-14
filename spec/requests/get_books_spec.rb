
require 'rails_helper'

RSpec.describe 'books requests', type: :request do
  describe 'get books', :vcr do
    it 'can get books for a city', :vcr do
      get '/api/v1/book-search?location=denver,co&quantity=5'

      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:data][:id]).to eq('null')
      expect(data[:data].keys.count).to eq(3)
      expect(data[:data].keys).to eq([:id, :type, :attributes])
      expect(data[:data][:type]).to eq('books')
      expect(data[:data][:attributes]).to be_a(Hash)
      expect(data[:data][:attributes].keys.count).to eq(4)
      expect(data[:data][:attributes].keys).to eq([:destination, :forecast, :total_books_found, :books])
      expect(data[:data][:attributes][:destination]).to be_a(String)
      expect(data[:data][:attributes][:destination]).to eq('denver,co')
      expect(data[:data][:attributes][:forecast].keys.count).to eq(2)
      expect(data[:data][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(data[:data][:attributes][:forecast]).to be_a(Hash)
      expect(data[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(data[:data][:attributes][:forecast][:temperature]).to be_a(Float)
      expect(data[:data][:attributes][:total_books_found]).to be_an(Integer)
      expect(data[:data][:attributes][:books]).to be_an(Array)
      expect(data[:data][:attributes][:books].length).to eq(5)
      data[:data][:attributes][:books].each do |book|
        expect(book[:isbn]).to be_an(Array)
        expect(book[:title]).to be_a(String)
        expect(book[:publisher]).to be_an(Array)
      end
    end
  end
end