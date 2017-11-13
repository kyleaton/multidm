class Messagehuman
	require 'json'

	def self.sendDM(channel, text, token)
		str = "https://slack.com/api/chat.postMessage?token=#{token}&channel=#{channel}&text=#{text}&as_user=true"
		str.gsub!("\u2019", "")
		HTTParty.get(str)
	end



end
