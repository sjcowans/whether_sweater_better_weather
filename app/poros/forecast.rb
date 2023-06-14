class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(forecast_data)
    @current_weather = current(forecast_data)
    @daily_weather = daily(forecast_data)
    @hourly_weather= hourly(forecast_data)
  end

  def current(forecast_data)
    {
    last_updated: forecast_data[:current][:last_updated],
    temperature: forecast_data[:current][:temp_f],
    feels_like: forecast_data[:current][:feelslike_f],
    humidity: forecast_data[:current][:humidity],
    uvi: forecast_data[:current][:uv],
    visibility: forecast_data[:current][:vis_miles],
    condition: forecast_data[:current][:condition][:text],
    icon: forecast_data[:current][:condition][:icon]
    }
  end

  def daily(forecast_data)
    daily = []
    forecast_data[:forecast][:forecastday].each do |forecast|
      daily << {
                  date: forecast[:date],
                  sunrise: forecast[:astro][:sunrise],
                  sunset: forecast[:astro][:sunset],
                  max_temp: forecast[:day][:maxtemp_f],
                  min_temp: forecast[:day][:mintemp_f],
                  condition: forecast[:day][:condition][:text],
                  icon: forecast[:day][:condition][:icon]
                }
    end
    daily
  end

  def hourly(forecast_data)
    hourly = []
    forecast_data[:forecast][:forecastday].each do |forecast|
      forecast[:hour].each do |hour|
        hourly << {
                    time: hour[:time],
                    temperature: hour[:temp_f],
                    conditions: hour[:condition][:text],
                    icon: hour[:condition][:icon]
                  }
      end
    end
    hourly
  end
end