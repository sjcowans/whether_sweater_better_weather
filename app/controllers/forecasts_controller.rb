class ForecastsController < ApplicationController

  def show
    city = SearchFacade.new(params)
    coordinates = city.city_search
    @city = City.new(name: params[:location], longitude: coordinates[:lng],  latitude: coordinates[:lat])
    @city.save
    render json: CitySerializer.new(@city)
  end
end
