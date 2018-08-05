#! /usr/bin/env ruby

require 'bundler'
require 'json'

# Gems
Bundler.require(:default)

# Database
require_relative 'data/db.rb'

# Config
require_relative 'config/startup.rb'

# Extensions
require_relative 'ext/include'

# Lib
require_relative 'lib/include'

# Models
require_relative 'models/include'

# Commands
require_relative 'commands/include'
