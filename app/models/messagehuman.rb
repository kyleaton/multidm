class Messagehuman
	require 'json'

	def self.sendDM(channel, text, token)
		url = "https://slack.com/api/chat.postMessage?token=#{token}&channel=#{channel}&text=#{text}&as_user=true"
		HTTParty.get(url)
	end



end
