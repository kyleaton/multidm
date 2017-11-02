class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	require 'cgi'

	def receive_message
		@webhook = CGI::parse(request.raw_post)
		$theText = @webhook["token"][0]
		puts @webhook.inspect
		if @webhook["token"] == "igdU33zedZ6zU7gevHrZDNWT"
			puts "SEND THE MESSAGE"
			Messagehuman.sendMessage("ok, you'll talk to them later")
		end
	end

	def homepage
	end
end
