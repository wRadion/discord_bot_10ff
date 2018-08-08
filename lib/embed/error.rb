module Embed
  class Error

    def self.send(channel, error, usage = nil, params = {})
      channel.send_embed do |embed|
        embed.color = '#AA0000'
        embed.add_field(name: ':no_entry_sign:  Erreur', value: error) if error
        embed.add_field(name: "Aide d'utilisation", value: usage) if usage

        if params[:footer]
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(params.delete(:footer))
        end

        params.each { |p, v| embed.send("#{p}=", v) }
      end
    end

  end
end
