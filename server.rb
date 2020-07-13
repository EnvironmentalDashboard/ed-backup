require "sinatra"
require "sinatra/reloader" if development?

require "rufus-scheduler"

def all_scripts
  puts "Backing up databases"
  system("bash scripts/dbs.sh")

  puts "Backing up uploads"
  system("bash scripts/uploads.sh")
end

configure do
  set :scheduler, Rufus::Scheduler.new

  settings.scheduler.every('1d') do
    all_scripts
  end
end

get "/" do
  settings.scheduler.in '10s' do
    all_scripts
  end

  "Will run all backup scripts in 10 seconds."
end
