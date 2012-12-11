module ApplicationHelper
  def page_action
    params[:action]
  end

  def page_controller
    params[:controller].gsub('/', '-')
  end

  def cp(page_name)
    #"btn" if (page_name ==  5)
    if page_name.present?
    #if !params[:bedrooms].nil?
    #((page_name).to_i == 1)? "btn" : "btn-link"
    #elsif
    #((page_name).to_i == 2)? "btn" : "btn-link"
    #  elsif
    #((page_name).to_i == 3)? "btn" : "btn-link"
    #    elsif
    #((page_name).to_i == 4)? "btn" : "btn-link"
    #      elsif
    ((page_name).to_i == 5)? "btn" : "btn-link"
    #        elsif
    #((page_name).to_i == 6)? "btn" : "btn-link"
    end
  end

end
