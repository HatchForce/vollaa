class UserMailer < ActionMailer::Base
  default from: "vollaa.startup@gmail.com"

  def mail_property_details(mail_id, id)
    @property = Property.find(id)
    @username = mail_id.split('@')[0]
    @template = render(:partial => '/home/send_email', :locals => {:property => @property, :name => @username})
    @mail = mail(:to => mail_id, :subject => "Property Details", :body => @template)
  end
end
