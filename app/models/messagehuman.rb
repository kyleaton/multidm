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
		body = {
			token: "xoxp-219592720864-220173653139-268864145494-a8695e33319b9809744304f17d57aafc",
			pretty: "1"
		}.to_json
		response = HTTParty.post(
 			"https://slack.com/api/users.list",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end

end