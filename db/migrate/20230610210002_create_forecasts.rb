class CreateForecasts < ActiveRecord::Migration[7.0]
  def change
    create_table :forecasts do |t|
      t.text :current_weather
      t.text :daily_weather, array: true
      t.text :hourly_weather, array: true

      t.timestamps
    end
  end
end
