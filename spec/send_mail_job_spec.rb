require 'spec_helper'

describe SendMailJob do

  describe ".perform" do
    let(:message){ 
      Message.create({
        :to => 'fake@example.com',
        :to_name => 'Ms. Fake',
        :from => 'noreply@uber.com',
        :from_name => 'Uber',
        :subject => 'A Message from Uber',
        :body => '<h1>Your Bill</h1><p>$10</p>'
      })
    }

    it 'send an email' do
      expect(SendMailJob.perform(message.id)).to be true
      expect(message.reload.delivered).to be true
    end
  end

end