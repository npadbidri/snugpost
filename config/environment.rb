# Load the rails application
require File.expand_path('../application', __FILE__)

SITE_EMAIL= 'pasicmesud@gmail.com'
# Initialize the rails application
Snugpost::Application.initialize!
ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.default_content_type = "text/html"