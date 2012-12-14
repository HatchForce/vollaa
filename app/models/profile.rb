class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :dob, :contact_number, :address
  belongs_to :user
end
