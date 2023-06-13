class Books
  attr_reader :destination, :forecast, :total_books_found, :books

  def initialize(destination, forecast, all_books, quantity)
    @destination = destination
    @forecast = format_forecast(forecast)
    @total_books_found = all_books[:numFound]
    @books = format_books(all_books, quantity)
  end

  def format_forecast(forecast)
    {
      summary: forecast.current_weather[:condition],
      temperature: forecast.current_weather[:temperature]
    }
  end

  def format_books(all_books, quantity)
    books = []
    all_books[:docs][0..(quantity.to_i - 1)].each do |book|
      books << {
                isbn: book[:isbn],
                title: book[:title],
                publisher: book[:publisher]
               } 
    end
    books
  end
end