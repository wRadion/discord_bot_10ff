require 'discordrb'

require_relative 'type/add'
require_relative 'type/del'
require_relative 'type/help'
require_relative 'type/list'
require_relative 'type/start'
require_relative 'type/stop'

require_relative 'type/join'

module Commands
  module Type
    extend Discordrb::Commands::CommandContainer

    # -- type --

    TYPE_DESCRIPTION = 'Commands for managing typing race.'.freeze
    TYPE_USAGE = '?type add|del|help|list|start|stop'.freeze

    command(:type, description: TYPE_DESCRIPTION, usage: TYPE_USAGE) do |event, *args|
      subcmd = args.delete_at(0)

      if subcmd.nil? || subcmd.empty?
        Embed::Error.send(event.channel, nil, "`#{TYPE_USAGE}`")
        return
      end

      command_class = "Commands::Type::#{subcmd&.capitalize}"

      if Object.const_defined?(command_class)
        Commands.execute(Object.const_get(command_class), event, *args)
      else
        Embed::Error.send(event.channel, "Command `#{subcmd}` inconnue.", "`#{TYPE_USAGE}`")
      end
    end

    # -- join --

    JOIN_DESCRIPTION = 'Join a pending typing race.'.freeze
    JOIN_USAGE = '?join'.freeze

    command(:join, description: JOIN_DESCRIPTION, usage: JOIN_USAGE) do |event, *args|
      Commands.execute(Commands::Type::Join, event, *args)
    end

    # ---------

  end
end
