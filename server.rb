require "sinatra"
require "sinatra/reloader" if development?

require "rufus-scheduler"

configure do
  set :scheduler, Rufus::Scheduler.new
end

get "/" do
  settings.scheduler.in '10s' do
    puts "Backing up uploads"
    system("bash scripts/uploads.sh")
  end

  "Hi!!!"
end
