require "sinatra"
require "sinatra/reloader" if development?

require "rufus-scheduler"

configure do
  set :scheduler, Rufus::Scheduler.new
end

get "/" do
  settings.scheduler.in '10s' do
    File.write('test', Time.now)
  end

  "Hi!!!"
end
