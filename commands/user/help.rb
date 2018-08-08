module Commands
  module User
    class Help

      def description
        "Donne des informations sur une commande `?type help iam|del|list`."
      end

      def usage
        '?user help <iam|del|list>'
      end

      def argc
        [1]
      end

      def execute(event, command)
        command_class = "Commands::User::#{command&.capitalize}"

        if Object.const_defined?(command_class)
          cmd = Object.const_get(command_class).new

          Embed::Success.send(
            event.channel,
            [
              { name: ':speech_balloon:  Description', value: cmd.description },
              { name: 'Utilisation', value: "`#{cmd.usage}`" }
            ]
          )
        else
          Embed::Error.send(event.channel, "Commande `#{command}` inconnue.", "`#{usage}`")
        end
      end

    end
  end
end
