class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"
			@userList = HTTParty.get("https://slack.com/api/users.list?token=xoxp-219592720864-220173653139-265033877552-f3a1fd016fbe6ed8c63c85c0ec52ead4")
 			@userList = @userList.parsed_response["members"]
 			puts @userList.inspect
 			@userList.each do |user|
 				puts user["id"] + " - " + user["team_id"] + " - " + user["name"]
 			end
 		end
	end

	def homepage
	end
end
