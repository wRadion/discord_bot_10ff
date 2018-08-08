module Embed
  class Success

    def self.send(channel, fields, params = {})
      channel.send_embed do |embed|
        embed.color = '#00AA00'
        fields.each { |f| embed.add_field(f) }

        if params[:footer]
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(params.delete(:footer))
        end

        params.each { |p, v| embed.send("#{p}=", v) }
      end
    end

  end
end
