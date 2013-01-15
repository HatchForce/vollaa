class PropertyMap < ActiveRecord::Base
  attr_accessible :city, :state, :place, :prop_details
  acts_as_gmappable :process_geocoding => false #(if custom lang and longi tudes)
  has_one :property

  def gmaps4rails_address
    #"#{self.place}, #{self.city}, #{self.state}"
    city = Property.find_all_by_city('');
  end

  def gmaps4rails_marker_picture
    {
        "rich_marker" => "<div class='marker' id='markers'>#{self.prop_details}</div>"
  #      "picture" => "http://t3.gstatic.com/images?q=tbn:ANd9GcRjmRdMaxa5hxzHNmESYnzGFNZa-YGje7NOktZdjrH4Y4q8doWim4dtBtw",
  #      "width" => 32,
  #      "height" => 32
    }
  end

  def gmaps4rails_infowindow
    "This is info window"
  end
end
