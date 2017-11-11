class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		#if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"
			# does the token change each time? what token do i use? 
			response = HTTParty.get("https://slack.com/api/users.list?token=xoxp-219592720864-220173653139-265033877552-f3a1fd016fbe6ed8c63c85c0ec52ead4")
 		#end
	end

	def homepage
	end
end
