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
	 				newUser = Message.new(user_id: user["id"], team_id: user["team_id"], user_name: user["name"])
	 				newUser.save
	 			end
 			end

	 		@dmList = HTTParty.get("https://slack.com/api/im.list?token=xoxp-219592720864-220173653139-265033877552-f3a1fd016fbe6ed8c63c85c0ec52ead4")	
	 		@dmList = @dmList.parsed_response["ims"]
	 		puts @dmList.inspect

	 		@userText = @webhook["text"][0]
	 		@splitText = @userText.split(" ") if !@userText.nil?
	 		@userToText = Array.new
	 		@splitText.each do |word|
	 			if word[0] == "@"
	 				word.slice!(0)
	 				@userToText.push(word)
	 			end
	 		end

	 		puts @userToText.inspect
 		end
	end

	def homepage
	end
end
