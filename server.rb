require "sinatra"
require "sinatra/reloader" if development?

require "rufus-scheduler"

configure do
  set :scheduler, Rufus::Scheduler.new
end

get "/" do
  settings.scheduler.in '10s' do
    puts "Backing up databases"
    system("bash scripts/dbs.sh")
  end

  "Hi!!!"
end
