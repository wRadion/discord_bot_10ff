module Commands
  module Type
    class Join

      def description
        'Permet de rejoindre une course.'
      end

      def usage
        Commands::Type::JOIN_USAGE
      end

      def argc
        [0]
      end

      def execute(event)
        user = event.user

        if $typingrace.started?
          Embed::Error.send(event.channel, 'Une course est actuellement en cours.')
        elsif !$typingrace.launched?
          Embed::Error.send(event.channel, "Il n'y a aucune course en cours.")
        elsif $typingrace.in_race?(user)
          Embed::Error.send(event.channel, 'Vous êtes déjà dans la course.')
        else
          $typingrace.join(user)

          Embed::Success.send(
            event.channel,
            [
              {
                name: "#{user.username} a rejoint la course !",
                value: 'Tapez `?type start` pour commencer la course une fois que tout le monde est prêt.'
              }
            ]
          )

          user.pm('Le texte va vous être envoyé ici ! Soyez prêt !')
        end
      end

    end
  end
end
