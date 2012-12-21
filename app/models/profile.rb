class Profile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :dob, :contact_number, :address, :user_id, :name, :image, :remote_image_url,:id,:email
  belongs_to :user
  mount_uploader :image, ImageUploader
end
