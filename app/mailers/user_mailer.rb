class UserMailer < ActionMailer::Base
  default from: "vollaa@gmail.com"
  def mail_property_details(mail_id,id)
    @property = Property.find(id)
    @user_name = mail_id.split('@')[0]
    mail(:to => mail_id, :subject => "Property Details")
  end
end
