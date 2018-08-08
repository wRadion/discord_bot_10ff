require_relative '../config/db'

require_relative '../lib/browser/tenff'

class User < Sequel::Model

  def self.find_or_error(event)
    user = User.where(discord_id: event.user.id).first

    if user.nil?
      Embed::Error.send(
        event.channel,
        "Vous ne pouvez pas utiliser cette commande car vous n'avez pas associé votre compte 10FastFingers.",
        "`?iam <votre id 10ff>`"
      )
      nil
    else
      user
    end
  end

  def self.fetch_10ff_name(tenff_id)
    user = User.where(tenff_id: tenff_id).first

    return user[:tenff_name] if user

    Browser::Tenff.new.fetch_user_info(tenff_id)[:name]
  end

end
