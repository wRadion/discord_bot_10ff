module Commands
  module Type
    class Start

      def description
        'Démarre une course de dactylographie.'
      end

      def usage
        '?type start'
      end

      def argc
        [0]
      end

      def execute(event)
        user = event.user

        if ::Text.count.zero?
          Embed::Error.send(
            event.channel,
            "Il n'y a aucun texte dans la base. Pour ajouter un texte, utilisez la commande `?type add <text>`."
          )
          return
        end

        if $typerace.started?
          Embed::Error.send(event.channel, 'Une course est actuellement en cours.')
          return
        end

        if $typerace.launched?
          $typerace.start!

          Embed::Success.send(
            $typerace.channel,
            [
              {
                name: ':checkered_flag:  La course a été lancée avec le texte suivant:',
                value: $typerace.text[:content]
              }
            ]
          )
        else
          $typerace.launch(event.channel)
          $typerace.join(user)

          Embed::Success.send(
            event.channel,
            [
              {
                name: ':keyboard:  Une course a été créée !',
                value: 'Tapez `?join` pour rejoindre la course ou `?type start` pour la commencer.',
              }
            ]
          )

          user.pm('Le texte va vous être envoyé ici ! Soyez prêt !')
        end
      end

    end
  end
end
