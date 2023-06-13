class ForecastsController < ApplicationController

  def show
    city = SearchFacade.new(params)
    coordinates = city.city_search
    City.new_city(params, coordinates)
    forecast_data = ForecastService.city_forecast(coordinates[:lat], coordinates[:lng])
    @forecast = Forecast.new(forecast_data)
    render json: { data: {
                          "id": "null",
                          "type": "forecast",
                          "attributes": @forecast
                        }
                      }
  end
end
