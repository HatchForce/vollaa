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

  def sel_param(param)
    (params[param].present?? params[param] : "") if !params[param].nil?
  end

  def radio_param(param, value)
    radio_button_tag param, value,(params[param => value].present?? {:checked => true} : {:checked => false})
  end

  #@profile_path =  profile_path(:user_id => current_user.id) || new_profile_path(:user_id => current_user.id)

  def number_to_indian_currency(number)
    "Rs.#{number.to_s.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/, "\\1,")}"
  end

end
