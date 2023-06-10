class CoordinateService

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://www.mapquestapi.com')
  end

  def self.city_coordinates(city)
    get_url("/geocoding/v1/address?key=#{ENV['GEOCODE_KEY']}&location=#{city}")
  end
end


