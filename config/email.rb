# Setting up the mailer
require 'mail'
require_relative "../lib/settings"

email = Settings.email

Mail.defaults do
  delivery_method :smtp, {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => email.domain,
    :user_name            => email.username,
    :password             => email.password,
    :authentication       => 'plain',
    :enable_starttls_auto => true }
end
