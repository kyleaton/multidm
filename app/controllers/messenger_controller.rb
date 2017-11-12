class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"

			findTeam = Message.where(team_id: @webhook["team_id"][0])
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
	 		if !@userText.nil?
		 		@splitText = @userText.split(" ")
		 		@userToText = Array.new
		 		@splitText.each do |word|
		 			if word[0] == "@"
						@userText.slice!(word)
		 				word.slice!(0)
		 				@userToText.push(word)
		 			end
		 		end
		 		puts @userToText.inspect
	 		end
	 		@userIds = Array.new
	 		if !@userToText.empty?
		 		@userToText.each do |user|
		 			getUser = Message.find_by(team_id: @webhook["team_id"][0], user_name: user)
		 			@userIds.push(getUser.user_id) if !getUser.nil?
		 		end
	 		end
	 		puts "User IDS"
			@finalList = Array.new
	 		puts @userIds.inspect
	 		@dmList.each do |dm|
				@userIds.each do |userid|
					if userid == dm["user"]
						@finalList.push(dm["id"])
					end
				end
			end

			puts "THE FINAL LIST"
			puts @finalList.inspect
			@finalList.each do |dm|
				Messagehuman.sendDM(dm, @userText)
			end


 		end
	end

	def homepage
	end

	def done
		puts request.raw_post.inspect
		puts "THE PARAMS"
		thecode = params["code"]
		puts thecode
		if !thecode.nil?
			@theToken = HTTParty.get("https://slack.com/api/oauth.access?client_id=219592720864.265033610496&client_secret=d5062fd434690b7d86bf58f68f7dc9ea&code=#{thecode}")
			@theToken.inspect
		end
	end
end
