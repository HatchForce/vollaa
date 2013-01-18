class SavedProperty < ActiveRecord::Base
  attr_accessible :property_id, :user_id
  belongs_to :user
end
