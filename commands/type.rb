module Commands
  module Type
    extend Discordrb::Commands::CommandContainer

    command :type do |event, cmd, *args|

      begin
        Object.const_get("::Commands::Type::#{cmd.capitalize}").execute(event, *args)
      rescue NameError
        return 'Commande inconnue.'
      end

      return 'Done.'
    end

  end
end
