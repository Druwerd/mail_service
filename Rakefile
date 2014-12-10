require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require "rspec/core/rake_task"
require 'resque/tasks'
require './jobs/send_mail_job'

# Default directory to look in is `/specs`
# Run with `rake spec`
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color']
end

task :default => :spec