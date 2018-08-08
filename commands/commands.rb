require_relative '../lib/embed'

require_relative './type'
require_relative './user'

module Commands

  PAGINATION_LIMIT = 15

  def self.execute(command, event, *args)
    cmd = command.new

    if cmd.argc.nil? || cmd.argc.include?(args.count)
      cmd.execute(event, *args)
    else
      Embed::Error.send(event.channel, "Mauvais nombre d'arguments.", "`#{cmd.usage}`")
    end
  end

  def self.register_in(bot)
    # Include your commands module here
    # e.g.: bot.include!(YOUR_COMMANDS_MODULE)

    # ?type
    # ?join
    bot.include!(Type)

    # ?iam
    # ?user
    bot.include!(User)
  end

end
