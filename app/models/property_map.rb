class PropertyMap < ActiveRecord::Base
   attr_accessible :city, :state, :place, :prop_details
  acts_as_gmappable #:process_geocoding => false (if custom lang and longi tudes)

  def gmaps4rails_address
    #raise "checking gmaps4rails_address"
    "#{self.place}, #{self.city}, #{self.state}"
  end
end
