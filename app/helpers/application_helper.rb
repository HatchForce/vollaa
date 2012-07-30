module ApplicationHelper
  def page_action
    params[:action]
  end

  def page_controller
    params[:controller].gsub('/', '-')
  end
end
