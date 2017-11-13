class Messagehuman
	require 'json'

	def self.sendDM(channel, text, token)
		text = Messagehuman.ascii(text)
		url = "https://slack.com/api/chat.postMessage?token=#{token}&channel=#{channel}&text=#{text}&as_user=true"

		HTTParty.get(url)
	end

	def self.ascii(str)
		str.gsub!("\u2019", "\'")
		str.gsub!("\u201D", "\"")
		str.gsub!("&", "&amp;")
		str.gsub!("<", "&lt;")
		str.gsub!(">", "&gt;")
	end



end
