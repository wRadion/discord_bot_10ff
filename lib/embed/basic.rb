module Embed
  class Basic

    def self.send(channel, text, params = {})
      channel.send_embed do |embed|
        embed.color = '#CCCCCC'
        embed.description = text

        if params[:footer]
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(params.delete(:footer))
        end

        params.each { |p, v| embed.send("#{p}=", v) }
      end
    end

  end
end
