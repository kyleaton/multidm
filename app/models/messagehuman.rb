class Messagehuman
	require 'json'

	def self.sendDM(channel, text)
		HTTParty.get("https://slack.com/api/chat.postMessage?token=xoxp-219592720864-220173653139-265033877552-f3a1fd016fbe6ed8c63c85c0ec52ead4&channel=#{channel}&text=#{text}&as_user=true")
	end



end