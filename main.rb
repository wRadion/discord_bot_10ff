require_relative 'config/discord_bot'
require_relative 'config/autoload'

# Database
require_relative 'db/config'

bot = Discordrb::Commands::CommandBot.new(DISCORD_CONFIG)
::Commands.register_in(bot)
bot.run

exit 0
