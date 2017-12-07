class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	include MessengerHelper

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		@sentHelp = false
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"

			teamToken = Team.find_by(user_id: @webhook["user_id"][0]).access_token if !Team.find_by(user_id: @webhook["user_id"][0]).nil?
			puts "THE TEAM TOKEN"
			puts teamToken.inspect
			if teamToken.nil?
				# send ephermeral message thing
				Messagehuman.sendResponse(@webhook["response_url"][0])
			else
				@userList = HTTParty.get("https://slack.com/api/users.list?token=#{teamToken}")
		 		@userList = @userList.parsed_response["members"]
		 		puts @userList.inspect

				@userInfo = Array.new
				@userList.each do |user|
					pushArray = Array.new
					pushArray.push(user["id"])
					pushArray.push(user["name"])
					@userInfo.push(pushArray)
				end

				puts "THE USER INFO"
				puts @userInfo.inspect

		 		@dmList = HTTParty.get("https://slack.com/api/im.list?token=#{teamToken}")
		 		@dmList = @dmList.parsed_response["ims"]
		 		puts @dmList.inspect

				if @webhook["text"][0].include?("help") && @webhook["text"][0].exclude?("@")
					userMessage = Messagehuman.sendUserMessage(@webhook["user_id"][0], @webhook["channel_id"][0], "Need some help? No problem! Here is the formula for using multidm: _/multidm @john @jane type your message here_ \n if your problem persists: email *alecaej2002@gmail.com*", teamToken)
					@sentHelp = true
					puts "THE USER MESSAGE"
					puts userMessage
				end

		 		@userText = @webhook["text"][0]
				puts "USER TEXT: " + @userText
		 		if !@userText.nil?
			 		@splitText = @userText.split(" ")
			 		@userToText = Array.new
			 		@splitText.each do |word|
			 			if word[0] == "@"
							fullUserName = word
							fullUserName = fullUserName.gsub("@", "")
							puts "THE FULL USERNAME: " + fullUserName
							if @userInfo.to_s.include?(fullUserName)
								@userText.slice!(word)
			 					word.slice!("@")
			 					@userToText.push(word)
							end
			 			end
			 		end
					puts "OTHER STUFF"
			 		puts @userToText.inspect
		 		end


		 		@userIds = Array.new
		 		if !@userToText.empty?
			 		@userToText.each do |user|
						puts "USER: " + user.inspect
						@userInfo.each do |aUser|
							puts "AUSER: " + aUser.inspect
				 			getUser = aUser if aUser[1] == user
				 			@userIds.push(getUser[0]) if !getUser.nil?
						end
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
				if @finalList.empty? && @sentHelp == false
					messageSent = Messagehuman.sendUserMessage(@webhook["user_id"][0], @webhook["channel_id"][0], "uh-oh! something went wrong! i think you forgot to add people to send your message to! use:  _/multidm help_", teamToken)
				else
					@finalList.each do |dm|
						messageSent = Messagehuman.sendMessage(dm, @userText, teamToken)
						puts messageSent
					end
				end

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
			puts "RIGHT FRICKEN HERE"
			@theToken = HTTParty.get("https://slack.com/api/oauth.access?client_id=219592720864.265033610496&client_secret=d5062fd434690b7d86bf58f68f7dc9ea&code=#{thecode}")
			puts @theToken
		end

		if !@theToken.nil?
		if @theToken["ok"] == true
			puts "IN HERE"
			@teamExisting = Team.where(user_id: @theToken["user_id"])
			puts "TEAM EXISTING?"
			puts @teamExisting.inspect
			if !@teamExisting.empty?
				puts "NOT NIL"
				@teamExisting.each do |team|
					team.destroy
				end
			end
			puts "NEW TEAM"
			newTeam = Team.new(access_token: @theToken["access_token"], user_id: @theToken["user_id"], team_name: @theToken["team_name"], team_id: @theToken["team_id"])
			newTeam.save()
		end
	end
end

	def contact
	end

	def privacy
	end



end
