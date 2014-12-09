require 'rspec'
require 'rack/test'
require_relative File.join('..', 'app', 'mail_service_app')

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end