class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'

	def receive_message
		@webhook = request.raw_post
		puts @webhook.inspect
		if @webhook["token"] = "caPwPxIyw5qrXnunVr2cN10R"
			puts "text: " + @webhook["text"].inspect
			if @webhook["text"] == "insult"
				Messagehuman.sendMessage("you ugly as poo")
			elsif @webhook["text"] == "compliment"
				Messagehuman.sendMessage("you're absolutely gorgeous")
			else
				Messagehuman.sendMessage("sorry, i don't understand")
			end
		end
	end

	def homepage
	end
end
