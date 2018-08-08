require 'sequel'

module Commands
  module User
    class Iam

      def description
        Commands::User::IAM_DESCRIPTION
      end

      def usage
        Commands::User::IAM_USAGE
      end

      def argc
        [1, 2]
      end

      def execute(event, tenff_id, name = nil)
        if !(tenff_id =~ /\d+/)
          Embed::Error.send(
            event.channel, "Votre id 10FastFingers doit être un nombre entier.", usage
          )
          return
        end

        # TODO: Put all of that in a separate service? (or User)
        tenff_name = ::User.fetch_10ff_name(tenff_id)
        name ||= tenff_name

        user = ::User.create(
          name: name,
          discord_id: event.user.id.to_s,
          tenff_id: tenff_id,
          tenff_name: tenff_name
        )

        Embed::Success.send(
          event.channel,
          [
            {
              name: ':white_check_mark:  Utilisateur ajouté !',
              value: "L'utilisateur `#{user[:name]}` a été créé avec succes."
            }
          ]
        )
      rescue Browser::Tenff::UserNotFoundError
        Embed::Error.send(
          event.channel,
          'Aucun utilisateur ne porte cet id.'
        )
      rescue Sequel::ConstraintViolation
        Embed::Error.send(
          event.channel,
          "Une erreur s'est produite lors de la création de l'utilisateur."
        )
      end

    end
  end
end
