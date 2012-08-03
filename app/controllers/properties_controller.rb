class PropertiesController < ApplicationController

  def vollaa_property_show

    @property = Property.find_by_id(params[:id])

    if @property.nil?
      redirect_to root_path
    else
      render :layout => 'iframe'
    end
  end
end
