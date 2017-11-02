class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'

	def receive_message
		@webhook = request.raw_post
		$theText["token"].inspect
		puts @webhook.inspect
		if @webhook["token"] == "igdU33zedZ6zU7gevHrZDNWT"
			Messagehuman.sendMessage("ok, you'll talk to them later")
		end
	end

	def homepage
	end
end
