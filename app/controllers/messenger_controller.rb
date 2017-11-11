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
			response = HTTParty.get("https://slack.com/api/users.list?token=xoxp-219592720864-220173653139-268864145494-a8695e33319b9809744304f17d57aafc")
 		#end
	end

	def homepage
	end
end
