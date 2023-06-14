require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists and has attributes' do
    trip = RoadTrip.new({origin: 'home', destination: 'the motherland'}, {travel_time: 'go time'}, [{time: 'noon', temp_f: 9000, condition: { text: 'HOT' }}])

    expect(trip).to be_a(RoadTrip)
    expect(trip.start_city).to eq('home')
    expect(trip.end_city).to eq('the motherland')
    expect(trip.travel_time).to eq('go time')
    expect(trip.weather_at_eta).to eq({ datetime: 'noon', temperature: 9000, condition: 'HOT' })
  end
end