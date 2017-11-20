class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	include MessengerHelper

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"

			teamToken = Team.find_by(team_id: @webhook["team_id"][0]).access_token if !Team.find_by(team_id: @webhook["team_id"][0]).nil?
			puts "THE TEAM TOKEN"
			puts teamToken.inspect
			findTeam = Message.where(team_id: @webhook["team_id"][0])
			if findTeam.empty?
				@userList = HTTParty.get("https://slack.com/api/users.list?token=#{teamToken}")
	 			@userList = @userList.parsed_response["members"]
	 			puts @userList.inspect
	 			@userList.each do |user|
	 				puts user["id"] + " - " + user["team_id"] + " - " + user["name"]
	 				newUser = Message.new(user_id: user["id"], team_id: user["team_id"], user_name: user["name"])
	 				newUser.save
	 			end
 			end

	 		@dmList = HTTParty.get("https://slack.com/api/im.list?token=#{teamToken}")
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
				puts "OTHER STUFF"
		 		puts @userToText.inspect
	 		end

			@emoji = MessengerHelper.emojis
			@chars = @userText.split("")
			@chars.each do |char|
				if !@emoji[char].nil?
					@userText.gsub!(char, @emoji[char])
				end
			end
			puts "emoji sutff"
			puts @userText.inspect


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
				messageSent = Messagehuman.sendDM(dm, @userText, teamToken)
				puts messageSent
			end


 		end
	end

	def homepage
	 @emoji = MessengerHelper.emojis
	 	puts @emoji["😜"]
	end

	def done
		puts request.raw_post.inspect
		puts "THE PARAMS"
		thecode = params["code"]
		puts thecode
		if !thecode.nil?
			puts "RIGHT FRICKEN HERE"
			@theToken = HTTParty.get("https://slack.com/api/oauth.access?client_id=219592720864.265033610496&client_secret=d5062fd434690b7d86bf58f68f7dc9ea&code=#{thecode}")
			puts @theToken
		end


		if @theToken["ok"] == true
			@teamExisting = Team.where(team_id: @theToken["team_id"])
			if !@teamExisting.nil?
				@teamExisting.each do |team|
					team.destroy
				end
			end
			newTeam = Team.new(access_token: @theToken["access_token"], user_id: @theToken["user_id"], team_name: @theToken["team_name"], team_id: @theToken["team_id"], channel_id: @theToken["incoming_webhook"]["channel_id"])
			newTeam.save()
		end

	end
end
