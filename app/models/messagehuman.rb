class Messagehuman
	require 'json'

	def self.sendDM(channel, text, token)
		text.gsub!("\u2019", "\'")
		text.gsub!("\u201D", "\"")
		text.gsub!("&", "\&amp;")
		HTTParty.get("https://slack.com/api/chat.postMessage?token=#{token}&channel=#{channel}&text=#{text}&as_user=true")
	end

	def self.sendMessage(channel, text, token)
		HTTParty.post("https://slack.com/api/chat.postMessage", :body => {:token => token, :channel => channel, :text => text, :as_user => true})
	end
end
