web: bundle exec unicorn -p $PORT -c ./unicorn.rb
redis: redis-server ./config/redis.conf
resque: bundle exec rake resque:work TERM_CHILD=1 QUEUES=*
