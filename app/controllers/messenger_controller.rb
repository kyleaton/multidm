class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"
			# does the token change each time? what token do i use? 
			Messagehuman.userlist()
 		end
	end

	def homepage
	end
end
