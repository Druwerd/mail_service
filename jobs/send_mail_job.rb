# Background Resque job to send email

require './app/init'

class SendMailJob
  @queue = :default

  def self.perform(message_id)
    message = Message.find(message_id)

    response = HTTP_MAILER.send_message(
      message.from,
      message.to,
      message.subject,
      message.body,
      message.from_name,
      message.to_name
    )

    if response.code == 200
      message.update(delivered: true)
    else
      false
    end

  end

end