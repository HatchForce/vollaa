class PropertyMapController < ApplicationController
  def index
    @prop_maps = PropertyMap.all
    @json = @prop_maps.to_gmaps4rails do |prop, marker|
      marker.infowindow render_to_string(:partial => "/property_map/infowindow", :locals => { :city => prop})
      marker.title "property Name"
      marker.json({ :population => prop.prop_details})

    end
  end
end
