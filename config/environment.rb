# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true


#ActionMailer::Base.smtp_settings = {
#    :address              => "smtp.gmail.com",
#    :port                 => 587,
    # :domain               => "gmail.com",
#    :user_name            => 'bansal.medha@gmail.com',
#    :password             => 'nirvikalpa',
#    :authentication       => "plain",
#    :enable_starttls_auto => false
#}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
