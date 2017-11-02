class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		puts @webhook.inspect
		if @webhook["token"][0] == "igdU33zedZ6zU7gevHrZDNWT"
			if @webhook["text"][0].blank?
				newMessage = Message.new(channel: @webhook["channel_name"][0], user_id: @webhook["user_id"][0])
				newMessage.save
			end

			if @webhook["text"][0] == "list"
				Messagehuman.sendMessage("your list of things")
			end
			
		end
	end

	def homepage
	end
end
