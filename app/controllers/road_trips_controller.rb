class RoadTripsController < ApplicationController
  def create
    if User.find_by_api_key(params[:api_key])
      search = SearchFacade.new(params)
      times = search.road_trip
      if times == false
        render json: ErrorMessageSerializer.serialize("Error: Invalid destination or location"), status: 401
      elsif times == 'impossible'
        @road_trip = RoadTrip.new(params, {travel_time: "Impossible"}, [{time: "", temp_f: "", condition: {text: ""}}])
        render json: { 
                        data: {
                                "id": "null",
                                "type": "road_trip",
                                "attributes": @road_trip
                              }
                      }, status: 201
      else
        coordinates = search.city_search(params[:destination])
        hours = times[:travel_time].split(":").first.to_i
        minutes = times[:travel_time].split(":")[1].to_i
        seconds = times[:travel_time].split(":")[2].to_i
        time = Time.now + hours.hours + minutes.minutes + seconds.seconds
        date = time.strftime("%Y-%m-%d")
        forecast_data = ForecastService.city_time_forecast(coordinates[:lat], coordinates[:lng], date, time.strftime("%H"))
        @road_trip = RoadTrip.new(params, times, forecast_data[:forecast][:forecastday][0][:hour])
        render json: { 
                        data: {
                                "id": "null",
                                "type": "road_trip",
                                "attributes": @road_trip
                              }
                      }, status: 201
      end
    else
      render json: ErrorMessageSerializer.serialize("Error: Invalid API key"), status: 401
    end
  end
end