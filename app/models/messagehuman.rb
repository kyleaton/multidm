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

	def self.userlist()
		# send message
		response = HTTParty.get(
 			"https://slack.com/api/users.list?token=xoxp-219592720864-220173653139-265033877552-f3a1fd016fbe6ed8c63c85c0ec52ead4"
		)
	end

end