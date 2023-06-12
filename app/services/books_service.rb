class BooksService

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://openlibrary.org')
  end

  def self.search_books(city)
    get_url("/search.json?q=#{city}")
  end
end




