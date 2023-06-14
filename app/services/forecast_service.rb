class ForecastService

  def self.get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com')
  end

  def self.city_forecast(lat, lon)
    get_url("/v1/forecast.json?key=#{ENV['FORECAST_KEY']}&q=#{lat},#{lon}&days=5&aqi=no&alerts=no")
  end

  def self.city_time_forecast(lat, lon, date, time)
    get_url("/v1/forecast.json?key=#{ENV['FORECAST_KEY']}&q=#{lat},#{lon}&days=1&dt=#{date}&hour=#{time}&aqi=no&alerts=no")
  end
end
