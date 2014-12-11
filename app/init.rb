# Initializes the App with gem dependencies, all the source files, and configuration settings

require 'bundler'
Bundler.require
require './models/message'
require './jobs/send_mail_job'

# Load settings for http_mailer
http_mailer_settings = YAML.load(File.open("./config/http_mailer.yml").read)
http_mailer_settings = ActiveSupport::HashWithIndifferentAccess.new(http_mailer_settings)

# This is the HttpMailer client used to send emails via HTTP
#   provided by a custom gem created for this exercise
HTTP_MAILER = HttpMailer::Client.new(http_mailer_settings)