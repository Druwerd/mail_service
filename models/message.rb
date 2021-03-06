class Message < ActiveRecord::Base
  EMAIL_FORMAT_REGEX = %r{[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}}

  validates :to, :to_name, :from, :from_name, :subject, :body, presence: true
  validates :to, :from, format: { with: EMAIL_FORMAT_REGEX }

  before_save :remove_html_tags
  after_create :enqueue_send_mail_job

  private
  def remove_html_tags
    self.body = Sanitize.fragment(self.body).strip.split(/\s+/).join(" ")
  end

  def enqueue_send_mail_job
    Resque.enqueue(SendMailJob, self.id)
  end
end