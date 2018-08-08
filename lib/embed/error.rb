module Embed
  class Error

    def self.send(channel, error_message, usage = nil, params = {})
      channel.send_embed do |embed|
        embed.color = '#AA0000'
        embed.add_field(name: ':no_entry_sign:  Erreur', value: error_message)
        embed.add_field(name: "Aide d'utilisation", value: usage) if usage

        params.each { |p, v| send("#{p}=", v) }
      end
    end

  end
end
