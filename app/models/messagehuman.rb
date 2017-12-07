class Messagehuman
	require 'json'

=begin
	def self.sendDM(channel, text, token)
		text.gsub!("\u2019", "\'")
		text.gsub!("\u201D", "\"")
		HTTParty.get("https://slack.com/api/chat.postMessage?token=#{token}&channel=#{channel}&text=#{text}&as_user=true")
	end
=end

	def self.sendMessage(channel, text, token)
		HTTParty.post("https://slack.com/api/chat.postMessage", :body => {:token => token, :channel => channel, :text => text, :as_user => true})
	end

	def self.sendUserMessage(user, channel, text, token)
		HTTParty.post("https://slack.com/api/chat.postEphemeral", :body => {:token => token, :user => user, :channel => channel, :text => text})
	end

	def self.sendResponse(url)
		HTTParty.post(url, :body => {:response_type => "ephemeral", :text => "it appears you haven't installed MultiDM! Visit <https://slackmultidm.herokuapp.com/#about> to install"})
	end
end
