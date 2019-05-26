desc "This task is called by the Heroku scheduler add-on"
task :download_videos => :environment do
  Video.download_videos
end