require 'discordrb'

require_relative '../lib/typing_race'

require_relative 'type/add'
require_relative 'type/del'
require_relative 'type/help'
require_relative 'type/list'
require_relative 'type/records'
require_relative 'type/start'
require_relative 'type/stop'

require_relative 'type/join'

module Commands
  module Type
    extend Discordrb::EventContainer
    extend Discordrb::Commands::CommandContainer

    # -- type --

    TYPE_DESCRIPTION = 'Commands for managing typing race.'.freeze
    TYPE_USAGE = '?type add|del|help|list|records|start|stop'.freeze

    command(:type, description: TYPE_DESCRIPTION, usage: TYPE_USAGE) do |event, *args|
      return unless ::User.find_or_error(event)

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
      return unless ::User.find_or_error(event)

      Commands.execute(Commands::Type::Join, event, *args)
    end

    # -- pm   --

    private_message do |event|
      if !event.text.start_with?('?') && $typingrace.started? && $typingrace.in_race?(event.user)
        $typingrace.finish(event)

        if $typingrace.everyone_finished?
          Embed::Success.send(
            event.channel,
            [
              {
                name: ':clap:  Bravo !',
                value: "Les résultats ont été envoyés dans le channel ##{$typingrace.channel.name}."
              }
            ]
          )

          $typingrace.stop
        else
          Embed::Success.send(
            event.channel,
            [
              {
                name: ':clap:  Bravo !',
                value: 'Les résultats de la course vont être envoyés lorsque tout le monde aura fini ou si vous arrêtez la course en tapant `?type stop`.'
              }
            ]
          )
        end
      end
    end

    # ---------

  end
end
