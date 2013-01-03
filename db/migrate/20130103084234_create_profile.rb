class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profile do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.string :address
      t.integer :contact_number
      t.string  :city
      t.string  :state
      t.string :image

      t.timestamps
    end
  end
end
