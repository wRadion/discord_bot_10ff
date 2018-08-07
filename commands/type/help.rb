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

          "**Description:** #{cmd.description}\n**Usage:** #{cmd.usage}"
        else
          usage
        end
      end

    end
  end
end
