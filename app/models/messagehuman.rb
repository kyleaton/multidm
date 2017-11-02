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