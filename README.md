# MailService

HTTP service to send emails via multiple email service providers.

The architectural design of this application is split into two main components:

1. HTTP service with data storage to process incoming web requests.
2. Background workers to process outgoing HTTP connections to email services.

This design keeps functionally in modular components which allows for isolated testing
of different functionality. The [http_mailer](https://github.com/Druwerd/http_mailer) 
gem created specifically for this application is a self contained unit which can be tested, 
rewritten and replaced should the requirementsof this application change.

This design takes performance into consideration. The high latency task of connecting to
email service provider APIs is done asynchronously using background Resque workers. This allows the
HTTP service to process incoming web requests quickly. This design is also scalable.
More servers or process workers can be added to the HTTP service and the background workers
independently to increase the load capacity.

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

## Language and Technology choices

* Ruby is simple, expresive, and powerful with many useful tools and libraries available.
* Sinatra is lightweight and a good choice for a web service with a small number of end points such as this one.

## Future Expansion

Make the order in which email service providers are connected to configurable.

The application tracks whether a email was delivered or not using a 
boolean field in the data record of each message. Add a mechanism to retry sending 
undelivered emails.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/http_mailer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
