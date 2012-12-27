class CreatePropertyMaps < ActiveRecord::Migration
  def change
    create_table :property_maps do |t|
      t.string :place
      t.string :city
      t.string :state
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.integer :prop_details
      t.references :property

      t.timestamps
    end
  end
end
