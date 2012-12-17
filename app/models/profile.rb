class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :dob, :contact_number, :address, :user_id, :name, :image, :remote_image_url
  belongs_to :user
  mount_uploader :image, ImageUploader
end
