class HomeController < ApplicationController

  def index

  end

  def search

  end

  def results
    @results = Property.where("property_type=? and city=?", params[:what], params[:where]).order().paginate(:per_page => 10, :page => params[:page])
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
