class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.text :weather

      t.timestamps
    end
  end
end
