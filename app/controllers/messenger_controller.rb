class MessengerController < ApplicationController
	protect_from_forgery with: :null_session
	require 'httparty'
	require 'json'
	def receive_message
		$webhook = request.raw_post
		puts $webhook.inspect
		if !$webhook.nil?



			# send message
			body = {
	   		text: "hi there, you said trip"
			}.to_json
			response = HTTParty.post(
	 			"https://hooks.slack.com/services/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",
	 			body: body,
	 			headers: { 'Content-Type' => 'application/json' }
			)


		end
	end

	def homepage
	end
end
