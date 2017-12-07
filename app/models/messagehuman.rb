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

	def self.sendUserMessage(url, text)
		HTTParty.post(url.to_s,
    :body => { :response_type => 'ephemeral',
               :text => text
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
	end

	def self.sendResponse(url)
		#HTTParty.post(url, :body => {:response_type => "ephemeral", :text => "it appears you haven't installed MultiDM! Visit <https://slackmultidm.herokuapp.com/#about> to install"})
		HTTParty.post(url.to_s,
    :body => { :response_type => 'ephemeral',
               :text => 'it appears you haven\'t installed MultiDM! Visit <https://slackmultidm.herokuapp.com/#about> to install'
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
	end
end
