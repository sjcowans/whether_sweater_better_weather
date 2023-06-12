class ForecastsController < ApplicationController

  def show
    city = SearchFacade.new(params)
    coordinates = city.city_search
    City.new_city(params, coordinates)
    forecast_data = ForecastService.city_forecast(coordinates[:lat], coordinates[:lng])
    @forecast = Forecast.new_forecast(forecast_data)
    render json: ForecastSerializer.new(@forecast)
  end
end
