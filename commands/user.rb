require 'discordrb'

require_relative 'user/iam'

require_relative 'user/help'
require_relative 'user/list'
require_relative 'user/del'

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

    USER_DESCRIPTION = 'Various command on 10ff users.'.freeze
    USER_USAGE = '?user del|help|list'.freeze

    command(:user, description: USER_DESCRIPTION, usage: USER_USAGE) do |event, *args|
      return unless ::User.find_or_error(event)

      subcmd = args.delete_at(0)

      if subcmd.nil? || subcmd.empty?
        Embed::Error.send(event.channel, nil, "`#{USER_USAGE}`")
        return
      end

      command_class = "Commands::User::#{subcmd&.capitalize}"

      if Object.const_defined?(command_class)
        Commands.execute(Object.const_get(command_class), event, *args)
      else
        Embed::Error.send(event.channel, "Command `#{subcmd}` inconnue.", "`#{USER_USAGE}`")
      end
    end

    # ----------

  end
end
