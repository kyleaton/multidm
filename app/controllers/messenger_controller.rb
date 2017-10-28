class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	def receive_message
		$webhook = request.raw_post
		puts $webhook.inspect
		if $webhook["token"] = "caPwPxIyw5qrXnunVr2cN10R"
			Messagehuman.sendMessage("hey there, I'm Alec")
		end
	end

	def homepage
	end
end
