require 'discordrb'

module Commands
  module Ping
    extend Discordrb::Commands::CommandContainer

    # -- ping --

    PING_DESCRIPTION = 'Ping le bot et indique le temps de réponse (en millisecondes).'.freeze
    PING_USAGE = '?ping'

    command(:ping, description: PING_DESCRIPTION, usage: PING_USAGE) do |event, *args|
      time = ((Time.now - event.timestamp) * 1000).round

      event << ":ping_pong: _Pong!_ (**#{time} ms**)"
    end

    # ---------

  end
end
