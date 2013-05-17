class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.references :coffee_shop, index: true
      t.string :name

      t.timestamps
    end
  end
end
