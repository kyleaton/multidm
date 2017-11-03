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
				newMessage = Message.new(channel: @webhook["channel_name"][0], user_id: @webhook["user_id"][0], channel_id: @webhook["channel_id"][0])
				newMessage.save
			end

			if @webhook["text"][0] == "list"
				@myMessages = Message.where(user_id: @webhook["user_id"][0])
				@messageString = String.new
				@myMessages.each do |message|
					if message.channel == "directmessage"
						user_id = message.channel_id.split('')
						user_id[0] = ''
						user_id = user_id.join
						@messageString = @messageString + "text <@#{user_id}>" + "\n"
					else
						@messageString = @messageString + "text <##{message.channel_id}|#{message.channel}>" + "\n"
					end
					Messagehuman.sendMessage(@messageString)
				end
			end

			if @webhook["text"][0] == "done"
				puts "INSIDE DONE"
				@messages = Message.where(channel_id: @webhook["channel_id"][0], user_id: @webhook["user_id"][0])
				if !@messages.empty?
					@messages.each do |message|
						message.destroy
					end
				end
			end

 		end
	end

	def homepage
	end
end
