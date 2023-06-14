class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(info, time, weather)
    @start_city = info[:origin]
    @end_city = info[:destination]
    @travel_time = time[:travel_time]
    @weather_at_eta = format_weather(weather)
  end

  def format_weather(weather)
    { 
      datetime: weather[0][:time],
      temperature: weather[0][:temp_f],
      condition: weather[0][:condition][:text]
    }
  end
end
