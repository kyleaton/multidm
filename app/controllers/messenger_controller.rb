class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	def receive_message
		$webhook = request.raw_post
		puts $webhook.inspect
	end

	def homepage
	end
end
