class Forecast < ApplicationRecord

  def self.new_forecast(info)
    serialize :current_weather
    serialize :daily_weather
    serialize :hourly_weather

    current = {
                last_updated: info[:current][:last_updated],
                temperature: info[:current][:temp_f],
                feels_like: info[:current][:feelslike_f],
                humidity: info[:current][:humidity],
                uvi: info[:current][:uv],
                visibility: info[:current][:vis_miles],
                condition: info[:current][:condition][:text],
                icon: info[:current][:condition][:icon]
              }
    daily = []
    hourly = []
    info[:forecast][:forecastday].each do |forecast|
      daily << {
                date: forecast[:date],
                sunrise: forecast[:astro][:sunrise],
                sunset: forecast[:astro][:sunset],
                max_temp: forecast[:day][:maxtemp_f],
                min_temp: forecast[:day][:mintemp_f],
                condition: forecast[:day][:condition][:text],
                icon: forecast[:day][:condition][:icon]
               }
      forecast[:hour].each do |hour|
        hourly << {
                    time: hour[:time],
                    temperature: hour[:temp_f],
                    conditions: hour[:condition][:text],
                    icon: hour[:condition][:text]
                  }
      end
    end
    Forecast.new(current_weather: current, daily_weather: daily, hourly_weather: hourly)
  end
end
