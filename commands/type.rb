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
      command_class = "Commands::Type::#{args.delete_at(0)&.capitalize}"

      if Object.const_defined?(command_class)
        cmd = Object.const_get(command_class).new

        if cmd.argc.nil? || cmd.argc.include?(args.count)
          cmd.execute(event, *args)
        else
          "Wrong number of arguments.\n**Usage:** #{cmd.usage}"
        end
      else
        "**Usage:** `#{TYPE_USAGE}`"
      end
    end

    # -- join --

    JOIN_DESCRIPTION = 'Join a pending typing race.'.freeze
    JOIN_USAGE = '?join'.freeze

    command(:join, description: JOIN_DESCRIPTION, usage: JOIN_USAGE) do |event|
      Commands::Type::Join.new.execute(event)
    end

    # ---------

  end
end