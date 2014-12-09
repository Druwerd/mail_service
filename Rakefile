require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require "rspec/core/rake_task"

namespace :db do
  task :load_config do
    require './config/environments.rb'
  end
end

# Default directory to look in is `/specs`
# Run with `rake spec`
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color']
end

task :default => :spec