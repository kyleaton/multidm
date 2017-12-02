desc "This task is called by the Heroku scheduler add-on"
task :stay_awake => :environment do
  puts "stay awake"
end

task :stay_awake_again => :environment do
  puts "staying awake"
end
