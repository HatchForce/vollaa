class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profile do |t|
      ## User Profile
      t.references :user
      t.string :first_name
      t.string :last_name
      t.date   :dob
      t.string :address
      t.integer :contact_number
      t.string :image
      t.timestamps
    end
  end
end
