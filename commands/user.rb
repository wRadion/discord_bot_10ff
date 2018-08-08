require 'discordrb'

require_relative 'user/iam'

module Commands
  module User
    extend Discordrb::Commands::CommandContainer

    # -- iam  --

    IAM_DESCRIPTION = 'Link your 10FastFingers account to this Discord.'.freeze
    IAM_USAGE = '?iam <your 10ff id> [username alias]'.freeze

    command(:iam, description: IAM_DESCRIPTION, usage: IAM_USAGE) do |event, *args|
      Commands.execute(Commands::User::Iam, event, *args)
    end

    # -- user --

    # ----------

  end
end
