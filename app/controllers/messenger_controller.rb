class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"
			findTeam = Message.where(team_id: @webhook["team_id"])
			if findTeam.empty?
				@userList = HTTParty.get("https://slack.com/api/users.list?token=xoxp-219592720864-220173653139-265033877552-f3a1fd016fbe6ed8c63c85c0ec52ead4")
	 			@userList = @userList.parsed_response["members"]
	 			puts @userList.inspect
	 			@userList.each do |user|
	 				puts user["id"] + " - " + user["team_id"] + " - " + user["name"]
	 				newUser = Message.new()
	 				newUser.save(user_id: user["id"], team_id: user["team_id"], user_name: user["name"])
	 			end
 			end
 		end
	end

	def homepage
	end
end
