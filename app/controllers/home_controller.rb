class HomeController < ApplicationController

  def index

  end

  def search

  end

  def results
    search = Property.search do
      fulltext params['what'] + ' ' + params['where']
      with(:property_type,  params[:property_type]) if params[:property_type].present?
      with(:bedrooms,  params[:bedrooms]) if params[:bedrooms].present?
      with(:property_price).greater_than(params[:price_min]) if params[:price_min].present? and !params[:price_max].present?
      with(:property_price).less_than(params[:price_max]) if params[:price_max].present? and !params[:price_min].present?
      with(:property_price, params[:price_min]..params[:price_max]) if params[:price_max].present? and params[:price_min].present?

      paginate :page => params[:page], :per_page => 10
    end
    @results = search.results
  end

  def send_details
    property_id = params[:property_id]
    emails = params[:emails].split(',')
    emails.each do |email|
      email = email.strip
      if email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
        UserMailer.mail_property_details(email, property_id).deliver
      end
    end
  end
end
