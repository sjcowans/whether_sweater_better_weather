class BooksController < ApplicationController

  def index
    search = SearchFacade.new(params)
    all_books = search.books_search
    binding.pry
    coordinates = search.city_search
    weather = ForecastService.city_forecast(coordinates[:lat], coordinates[:lng])
    forecast = Forecast.new_forecast(forecast_data)
  end
end