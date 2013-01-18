class CreateSavedProperties < ActiveRecord::Migration
  def change
    create_table :saved_properties do |t|
      t.integer :property_id
      t.integer :user_id

      t.timestamps
    end
  end
end
