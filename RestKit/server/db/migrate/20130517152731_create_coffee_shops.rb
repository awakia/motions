class CreateCoffeeShops < ActiveRecord::Migration
  def change
    create_table :coffee_shops do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
