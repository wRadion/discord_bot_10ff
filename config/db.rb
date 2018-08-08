require 'sequel'

# Database initialization
DB ||= Sequel.sqlite('db/sqlite.db').freeze

require_relative '../models/user'
require_relative '../models/text'
require_relative '../models/text_score'
require_relative '../models/competition'
require_relative '../models/quiz'
