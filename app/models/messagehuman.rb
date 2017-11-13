class Messagehuman
	require 'json'

	def self.sendDM(channel, text, token)
		HTTParty.get("https://slack.com/api/chat.postMessage?token=#{token}&channel=#{channel}&text=#{text}&as_user=true")
	end



end
