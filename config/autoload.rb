# Core
require 'bundler'
require 'json'

# Gems
Bundler.require(:default)

# Require extensions
require_all 'ext/'

# Autoload everything else
DIRS = %w(
  commands
  lib
  models
)

AwesomeLoader.autoload do
  DIRS.each { |d| paths [d, '**', '*.rb'] }
end
