require_relative '../config/db'

class User < Sequel::Model

  def self.find_or_error(event)
    user = User.where(discord_id: event.user.id).first

    if user.nil?
      Embed::Error.send(
        event.channel,
        "Vous ne pouvez pas utiliser cette commande car vous n'avez pas associé votre compte 10FastFingers.",
        "`?iam <votre id 10ff>`"
      )
    else
      user
    end
  end

end
