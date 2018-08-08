module Commands
  module Type
    class Help < Base

      def description
        "Donne des informations sur une commande `?type help add|del|list|start|stop`."
      end

      def usage
        '`?type help <add|del|help|list|start|stop>`'
      end

      def argc
        [1]
      end

      def execute(event, command)
        command_class = "Commands::Type::#{command&.capitalize}"

        if Object.const_defined?(command_class)
          cmd = Object.const_get(command_class).new

          Embed::Success.send(
            event.channel,
            [
              { name: ':speech_balloon:  Description', value: cmd.description },
              { name: 'Utilisation', value: cmd.usage }
            ]
          )
        else
          Embed::Error.send(event.channel, "Commande `#{command}` inconnue.", usage)
        end
      end

    end
  end
end
