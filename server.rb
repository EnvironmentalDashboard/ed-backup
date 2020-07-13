require "sinatra"
require "sinatra/reloader" if development?

require "date"

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
  @times = settings.scheduler.jobs.map(&:next_time).map(&:to_i).map { |t| Time.at(t).to_datetime } .sort
  erb :index
end

post "/schedule" do
  settings.scheduler.in '1m' do
    all_scripts
  end

  200
end
