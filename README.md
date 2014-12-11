# MailService

HTTP service to send emails via multiple email service providers.

## System Dependencies

* PostgreSQL
* Redis

## Installation

Setup:
    
    $ bundle install
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate

Then run using foreman:

    $ bundle exec foreman start

## Usage

    $ curl -H "Content-Type: application/json" -d '{"to":"fake@example.com","to_name":"Ms. Fake","from":"noreply@uber.com","from_name":"Uber","subject":"A Message from Uber","body":"\u003ch1\u003eYour Bill\u003c/h1\u003e\u003cp\u003e$10\u003c/p\u003e"}' localhost:5000/email

## Contributing

1. Fork it ( https://github.com/[my-github-username]/http_mailer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
