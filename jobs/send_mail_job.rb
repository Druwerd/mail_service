require './app/init'

class SendMailJob
  @queue = :default

  def self.perform(message_id)
    message = Message.find(message_id)
    puts message.subject
  end

end