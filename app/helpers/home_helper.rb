module HomeHelper

  def type_sel(name,value)
    link_to name, params.merge(:property_type => value), :class => ((params[:property_type]) == value)? "sel_nav type_link" : "type_link"
  end

  def type_clear(value)
    ((params[:property_type]) == value)? (link_to 'Clear', params.except(:property_type), class: 'nav_clear type_link') : ''
  end


  def bedroom_sel(name,value)
    link_to name, params.merge(:bedrooms => value), :class => ((params[:bedrooms]).to_i == value)? "sel_nav" : ""
  end

  def bed_clear(value)
    ((params[:bedrooms]).to_i == value)? (link_to 'Clear', params.except(:bedrooms), class: 'nav_clear') : ''
  end


  def city_sel(name,value)
    link_to name, params.merge(:city => value), :class => ((params[:city]) == value)? "sel_nav" : ""
  end

  def city_clear(value)
    ((params[:city]) == value)? (link_to 'Clear', params.except(:city), class: 'nav_clear') : ''
  end


  def state_sel(name, value)
    link_to name, params.merge(:state => value), :class => ((params[:state]) == value)? "sel_nav" : ""
  end

  def state_clear(value)
    ((params[:state]) == value)? (link_to 'Clear', params.except(:state), class: 'nav_clear') : ''
  end


  def price_sel(name, val1,val2)
    link_to name,params.merge(:price_min => val1, :price_max => val2), :class => ((params[:price_min].to_i == val1) && (params[:price_max].to_i == val2))? "sel_nav" : ""
  end

  def price_clear(val1,val2)
    ((params[:price_min].to_i == val1) && (params[:price_max].to_i == val2))? (link_to 'Clear', params.except(:price_min,:price_max), class: 'nav_clear') : ''
  end


  def area_sel(name, val1,val2)
    link_to name,params.merge(:area_min => val1,:area_max => val2),:class => ((params[:area_min].to_i == val1) && (params[:area_max].to_i == val2))? "sel_nav" : ""
  end

  def area_clear(val1,val2)
    ((params[:area_min].to_i == val1) && (params[:area_max].to_i == val2))? (link_to 'Clear', params.except(:area_min,:area_max), class: 'nav_clear') : ''
  end

  def sort_by(sort,direction)
    order_by sort, direction
  end

  def sort_column
    Property.column_names.include?(params[:sort]) ? params[:sort] : ""
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : ''
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction ), {:class => css_class}
  end

  def property_for_radio_btn(value)
    selected_radio = params[:property_for]

    if selected_radio == value
      radio_button_tag(:property_for, "#{value}", :checked => true)
    else
      radio_button_tag(:property_for, "#{value}")
    end
  end

end
