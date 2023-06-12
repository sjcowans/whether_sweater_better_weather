class BooksController < ApplicationController

  def index
    search = SearchFacade.new(params)
    all_books = search.books_search
    coordinates = search.city_search
    weather = ForecastService.city_forecast(coordinates[:lat], coordinates[:lng])
    forecast = Forecast.new_forecast(weather)
    render json: { data: {
                          "id": "null",
                          "type": "books",
                          "attributes": Books.new(params[:location], forecast, all_books, params[:quantity])
                        }
                  }
  end
end