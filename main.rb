require_relative 'config/discord_bot'

require_relative 'models/user'
require_relative 'models/text'
require_relative 'models/text_score'
require_relative 'models/competition'
require_relative 'models/quiz'

require_relative 'commands/commands'

bot = Discordrb::Commands::CommandBot.new(DISCORD_CONFIG)
::Commands.register_in(bot)
bot.run

exit 0
