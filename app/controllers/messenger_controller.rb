class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"
			newMessage = Message.new(channel: @webhook["channel_name"][0], user_id: @webhook["user_id"][0])
			newMessage.save
		end
	end

	def homepage
	end
end
