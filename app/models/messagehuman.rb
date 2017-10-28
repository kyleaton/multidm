class Messagehuman
	require 'json'

	def self.sendMessage(message)
		# send message
			body = {
	   		text: message
			}.to_json
			response = HTTParty.post(
	 			"https://hooks.slack.com/services/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",
	 			body: body,
	 			headers: { 'Content-Type' => 'application/json' }
			)
		end

end