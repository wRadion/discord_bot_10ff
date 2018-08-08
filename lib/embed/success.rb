module Embed
  class Success

    def self.send(channel, fields, params = {})
      channel.send_embed do |embed|
        embed.color = '#00AA00'
        fields.each { |f| embed.add_field(f) }

        params.each { |p, v| send("#{p}=", v) }
      end
    end

  end
end
