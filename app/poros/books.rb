class Books
  attr_reader :destination, :forecast, :total_books_found, :books

  def initialize(destination, forecast, book_count, all_books)
    @destination = destination
    @forecast = forecast
    @total_books_found = book_count
    @books = all_books
  end
end

