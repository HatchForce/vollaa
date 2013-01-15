class PropertyMapController < ApplicationController
  def index
    @prop_maps = PropertyMap.all
    @json = @prop_maps.to_gmaps4rails do |prop, marker|
      marker.infowindow render_to_string(:partial => "/property_map/infowindow", :locals => { :property => prop})
      marker.title prop.place
      marker.json({ :population => prop.prop_details})
      #marker.picture ( {
      #    :picture => "http://www.investinpropertycapeverde.com/images/Cabonuba%20property.jpg",
      #    :width => 32,
      #    :height => 32
      #})
      marker.sidebar "This is sidebar"
    end
  end
end
