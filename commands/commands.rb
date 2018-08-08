require_relative '../lib/embed'

require_relative './type'

module Commands

  def self.register_in(bot)
    # Register your commands here
    # e.g.: bot.include!(YOUR_COMMANDS_MODULE)

    # ?type <subcmd> ...
    bot.include!(Type)
  end

end
