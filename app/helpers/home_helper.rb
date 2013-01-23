module HomeHelper



  def type_clear(value)
    ((params[:property_type]) == value)? (link_to 'Clear', params.except(:property_type), class: 'nav_clear type_link') : ''
  end

  def price_sel(name, val1,val2)
    link_to name,params.merge(:price_min => val1, :price_max => val2), :class => ((params[:price_min].to_i == val1) && (params[:price_max].to_i == val2))? "sel_nav" : ""
  end

  def pp_clear(value)
    ((params[:property_price]).to_i == value)? (link_to 'Clear', params.except(:property_price), class: 'nav_clear') : ''
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
