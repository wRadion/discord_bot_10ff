require 'bundler'
require 'json'

# Gems
Bundler.require(:default)

# Database
require_relative 'data/db.rb'
# Config
require_relative 'config/discord_bot.rb'
# Extensions
require_relative 'ext/include'
# Lib
require_relative 'lib/include'
# Models
require_relative 'models/include'
# Commands
require_relative 'commands/include'

bot = Discordrb::Commands::CommandBot.new(DISCORD_CONFIG)
::Commands.register_in(bot)
bot.run

exit 0
