class MapquestService

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

  def self.travel_time(origin, destination)
    get_url("/directions/v2/route?key=#{ENV['MAPQUEST_KEY']}&from=#{origin}&to=#{destination}")
  end

  def self.city_coordinates(city)
    get_url("/geocoding/v1/address?key=#{ENV['MAPQUEST_KEY']}&location=#{city}")
  end
end

