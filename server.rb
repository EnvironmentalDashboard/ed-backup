require "sinatra"
require "sinatra/reloader" if development?

require "date"

require "rufus-scheduler"
require "free_disk_space"

require "./tree.rb"

def all_scripts
  puts "Backing up SQL databases"
  system("bash scripts/dbs.sh")

  puts "Backing up Mongo databases"
  system("bash scripts/mongo.sh")

  puts "Backing up uploads"
  system("bash scripts/uploads.sh")
end

configure do
  set :scheduler, Rufus::Scheduler.new

  settings.scheduler.every('1d') do |job|
    if FreeDiskSpace.gigabytes('./public/backup') < 4
      # Try again in two days.
      job.next_time = Time.now + 60 * 60 * 24 * 2
    else
      all_scripts
    end
  end
end

get "/" do
  @space_left = FreeDiskSpace.gigabytes('./public/backup')
  @files_html = FileTree.new('./public/backup').to_html
  @times = settings.scheduler.jobs.map(&:next_time).map(&:to_i).map { |t| Time.at(t).to_datetime } .sort

  erb :index
end

post "/schedule" do
  settings.scheduler.in '1m' do
    all_scripts
  end

  200
end
