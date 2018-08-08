require_relative 'config/discord_bot'
require_relative 'config/db'

require_relative 'commands/commands'

bot = Discordrb::Commands::CommandBot.new(DISCORD_CONFIG)
::Commands.register_in(bot)
bot.run

exit 0
