class Messagehuman
	require 'json'

	def self.sendDM(channel, text, token)
		body = {
			channel: channel,
			text: text,
			as_user: true
		}.to_json
		response = HTTParty.post(
 			"https://slack.com/api/chat.postMessage?token=#{token}",
 			body: body,
 			headers: { 'Content-Type' => 'application/json' }
		)
	end



end
