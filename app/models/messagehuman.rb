class Messagehuman
	require 'json'

	def self.sendMessage()
		# send message
		body = {
			token: "xoxp-219592720864-220173653139-265033877552-f3a1fd016fbe6ed8c63c85c0ec52ead4",
			channel: "D6H418JNS",
   		text: "hey there"
		}.to_json
		response = HTTParty.post(
 			"https://slack.com/api/chat.postMessage",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

end