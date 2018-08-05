# Core
require 'bundler'
require 'json'

# Gems
Bundler.require(:default)

DIRS = %w(
  commands
  ext
  lib
  models
)

AwesomeLoader.autoload do
  DIRS.each { |d| paths [d, '**', '*.rb'] }
end
