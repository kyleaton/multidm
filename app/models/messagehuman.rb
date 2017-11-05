class Messagehuman
	require 'json'

	def self.sendMessage(message, url)
		# send message
		body = {
   		text: message
		}.to_json
		response = HTTParty.post(
 			"#{url}",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

end