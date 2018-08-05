# Database
require_relative 'db/config'

require_relative 'config/discord_bot'
require_relative 'config/autoload'

bot = Discordrb::Commands::CommandBot.new(DISCORD_CONFIG)
::Commands.register_in(bot)
bot.run

exit 0
