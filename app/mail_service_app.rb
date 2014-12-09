require 'bundler'
Bundler.require
require './config/environments' #database configuration
require './models/message'


post '/email' do
  content_type :json
  data = request.body.read
  if data.empty?
    status 400
    return {:error => "Invalid request. Missing 'message' data."}
  end

  attributes = JSON.parse(data)
  @message = Message.new(attributes)
  if @message.save
    {:success => "ok",
      :message_id => @message.id }.to_json
  else
    status 500
    {:error => "Unable to create message."}
  end
end