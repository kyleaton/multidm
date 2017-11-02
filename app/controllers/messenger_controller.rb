class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		$theText = @webhook
		puts @webhook.inspect
		if @webhook["token"] == "igdU33zedZ6zU7gevHrZDNWT"
			Messagehuman.sendMessage("ok, you'll talk to them later")
		end
	end

	def homepage
	end
end
