class RoadTripsController < ApplicationController
  def create
    if User.find_by_api_key(params[:api_key])
      search = SearchFacade.new(params)
      times = search.road_trip
      coordinates = search.city_search(params[:destination])
      hours = times[:travel_time].split(":").first.to_i
      minutes = times[:travel_time].split(":")[1].to_i
      seconds = times[:travel_time].split(":")[2].to_i
      time = Time.now + hours.hours + minutes.minutes + seconds.seconds
      date = time.strftime("%Y-%m-%d")
      hours = time.strftime("%H:%M:%S")
      forecast_data = ForecastService.city_time_forecast(coordinates[:lat], coordinates[:lng], date, time.strftime("%H"))
      @road_trip = RoadTrip.new(params, times, forecast_data[:forecast][:forecastday][0][:hour])
      render json: { data: {
        "id": "null",
        "type": "road_trip",
        "attributes": @road_trip
      }
    }, status: 201
    end
  end
end