class ForecastsController < ApplicationController

  def show
    city = SearchFacade.new(params)
    coordinates = city.city_search
    if coordinates == false
      render json: ErrorMessageSerializer.serialize("Error: No coordinates for city found"), status: 422
    else
      @city = City.new(name: params[:location], longitude: coordinates[:lng],  latitude: coordinates[:lat])
      if @city.save
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
  end
end
