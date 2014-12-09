ENV['RACK_ENV'] = 'test'

require 'spec_helper'

describe 'MailService App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "successful message" do
    let(:message){ 
      {
        :to => 'fake@example.com',
        :to_name => 'Ms. Fake',
        :from => 'noreply@uber.com',
        :from_name => 'Uber',
        :subject => 'A Message from Uber',
        :body => '<h1>Your Bill</h1><p>$10</p>'
      }.to_json
    }

    it "sends an email" do
      post '/email', message, {:content_type => :json, :accept => :json}
      expect(last_response).to be_ok
      json_response = JSON.parse(last_response.body)
      expect(json_response["success"]).to eq("ok")
      expect(json_response["message_id"]).to be_a Integer
    end

    it "converts the body HTML to plain text" do
      post '/email', message, {:content_type => :json, :accept => :json}
      expect(last_response).to be_ok
      json_response = JSON.parse(last_response.body)
      message_body = Message.find(json_response["message_id"]).body
      expect(message_body).to eq("Your Bill $10")
    end
  end

  context "unsuccessful message" do
    let(:message_with_blank_to_field){
      {
        :to => '',
        :to_name => 'Ms. Fake',
        :from => 'noreply@uber.com',
        :from_name => 'Uber',
        :subject => 'A Message from Uber',
        :body => '<h1>Your Bill</h1><p>$10</p>' 
      }.to_json
    }

    let(:message_with_missing_subject_field){
      {
        :to => 'fake@example.com',
        :to_name => 'Ms. Fake',
        :from => 'noreply@uber.com',
        :from_name => 'Uber',
        :body => '<h1>Your Bill</h1><p>$10</p>' 
      }.to_json
    }

    let(:message_with_invalid_to_email){
      {
        :to => 'fake',
        :to_name => 'Ms. Fake',
        :from => 'noreply@uber.com',
        :from_name => 'Uber',
        :subject => 'A Message from Uber',
        :body => '<h1>Your Bill</h1><p>$10</p>'
      }.to_json
    }

    let(:message_with_invalid_from_email){
      {
        :to => 'fake@example.com',
        :to_name => 'Ms. Fake',
        :from => '@uber.com',
        :from_name => 'Uber',
        :subject => 'A Message from Uber',
        :body => '<h1>Your Bill</h1><p>$10</p>'
      }.to_json
    }

    it "returns an error when fields are missing" do
      post '/email', message_with_blank_to_field, {:content_type => :json, :accept => :json}
      expect(last_response).to be_server_error

      post '/email', message_with_missing_subject_field, {:content_type => :json, :accept => :json}
      expect(last_response).to be_server_error
    end

    it "returns an error when email address is invalid" do
      post '/email', message_with_invalid_to_email, {:content_type => :json, :accept => :json}
      expect(last_response).to be_server_error

      post '/email', message_with_invalid_from_email, {:context_type => :json, :accept => :json}
      expect(last_response).to be_server_error
    end

    it "returns an error when no message data is provided" do
      post '/email', {}
      expect(last_response).to be_bad_request
    end
  end
  
end