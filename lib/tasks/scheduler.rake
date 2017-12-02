desc "This task is called by the Heroku scheduler add-on"
require 'httparty'
task :stay_awake => :environment do
  httpGet = HTTParty.get("https://slackmultidm.herokuapp.com/contact")
  puts httpGet.inspect
end

task :stay_awake_again => :environment do
  puts "staying awake"
end
