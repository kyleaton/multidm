class MessengerController < ApplicationController
	def receive_message
		$webhook = request.raw_post
		puts $webhook.inspect
	end

	def homepage
	end
end
