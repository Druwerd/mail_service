require 'rspec'
require 'rack/test'
require_relative File.join('..', 'app', 'mail_service_app')
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  Resque.inline = true
  I18n.enforce_available_locales = false

  conf.before(:each) do
    stub_request(:post, "https://sendgrid.com/api/mail.send.json").
         with(:body => {"api_key"=>"XXXXXXXXXXXX", "api_user"=>"user", "from"=>"noreply@uber.com", "fromname"=>"Ms. Fake", "subject"=>"A Message from Uber", "text"=>"Your Bill $10", "to"=>"fake@example.com", "toname"=>"Uber"},
              :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'171', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})
  end
end

