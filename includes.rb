# Core
require 'bundler'
require 'json'

# Gems
Bundler.require(:default)

# Database
require_relative 'db/config.rb'

# Config
require_relative 'config/discord_bot.rb'

# Extensions
require_relative 'ext/string'

# Lib

# Models
require_relative 'models/user'
require_relative 'models/text'
require_relative 'models/text_score'
require_relative 'models/competition'
require_relative 'models/quiz'

# Commands
require_relative 'commands/commands'
