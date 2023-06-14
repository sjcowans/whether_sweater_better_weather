require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    forecast = Forecast.new({
                              current: {
                                        last_updated: 1, temp_f: 100, feelslike_f: 101, humidity: 1.1, uv: 1, vis_miles: 5, condition: {text: 'hot', icon: 'sun'}
                                        },
                              forecast: {
                                          forecastday: [{
                                                          date: 'today', 
                                                          astro: {
                                                                    sunrise: 'morning', 
                                                                    sunset: 'evening'
                                                                    }, 
                                                          day: {
                                                                mintemp_f: 0, 
                                                                maxtemp_f: 100, 
                                                                condition: {
                                                                            text: 'hot', 
                                                                            icon: 'sun'
                                                                            }
                                                                }, 
                                                          
                                                          hour: [{
                                                                time: 1, 
                                                                temp_f: 99, 
                                                                condition: {
                                                                            text: 'still hot',
                                                                            icon: 'more sun'
                                                                            }
                                                                }]
                                                              
                                                          }]
                                          }
                              })

    expect(forecast).to be_a(Forecast)
    expect(forecast.current_weather).to eq({
                                            last_updated: 1,
                                            temperature: 100,
                                            feels_like: 101,
                                            humidity: 1.1,
                                            uvi: 1,
                                            visibility: 5,
                                            condition: 'hot',
                                            icon: 'sun'
                                            })
    expect(forecast.daily_weather).to eq([{
                                          date: 'today',
                                          sunrise: 'morning',
                                          sunset: 'evening',
                                          max_temp: 100,
                                          min_temp: 0,
                                          condition: 'hot',
                                          icon: 'sun'
                                        }])   
    expect(forecast.hourly_weather).to eq([{
                                          time: 1,
                                          temperature: 99,
                                          conditions: 'still hot',
                                          icon: 'more sun'
                                        }])                                       
  end
end