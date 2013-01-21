class Notifier < ActionMailer::Base
  default from: "vollaa.startup@gmail.com"

  def mail_property_details(mail_id, id)
    @property = Property.find(id)
    @username = mail_id.split('@')[0]
    @mail = mail(:to => mail_id, :subject => "Property Details")
  end

end
