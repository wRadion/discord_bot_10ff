require_relative 'includes'

bot = Discordrb::Commands::CommandBot.new(DISCORD_CONFIG)
::Commands.register_in(bot)
bot.run

exit 0
