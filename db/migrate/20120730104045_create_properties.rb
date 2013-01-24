class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :property_title
      t.string :property_type
      t.string :property_for
      t.integer :bedrooms
      t.integer :property_price
      t.string :built_up_area
      t.string :city
      t.string :state
      t.string :country
      t.string :property_age
      t.string :property_description
      t.string :property_image
      t.date :last_update
      t.string :more_link
      t.string :source
      t.string :local_area

      t.timestamps
    end

    add_index :properties, :more_link, :unique => true
  end

end
