class AddLocalAreaToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :local_area, :string
  end
end
