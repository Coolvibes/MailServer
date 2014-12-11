class UserMailer < ActionMailer::Base
  # default from: "medha@josh.com"
  def send_email(email)
    @email = email
    #@url  = 'http://example.com/login'
    mail(from: "bansal.medha@gmail.com", to: "rahul.garg@joshtechnologygroup.com", subject: 'Your first email from us!')

  end
end
