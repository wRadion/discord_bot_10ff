require_relative '../../models/text'

module Commands
  module Type
    class Start

      def description
        'Démarre une course de dactylographie.'
      end

      def usage
        '?type start [text id]'
      end

      def argc
        [0, 1]
      end

      def execute(event, text_id = nil)
        if !text_id.nil? && !(text_id =~ /\d+/)
          Embed::Error.send(event.channel, "L'id du texte doit être un nombre entier.")
          return
        end

        if ::Text.count.zero?
          Embed::Error.send(
            event.channel,
            "Il n'y a aucun texte dans la base. Pour ajouter un texte, utilisez la commande `?type add <text>`."
          )
          return
        end

        text = text_id.nil? ? ::Text.all.sample : ::Text[text_id]

        if text.nil?
          Embed::Error.send(event.channel, "Aucun texte trouvé avec pour id `#{text_id}`.")
          return
        end

        user = event.user

        if $typingrace.started?
          Embed::Error.send(event.channel, 'Une course est actuellement en cours.')
          return
        end

        if $typingrace.launched?
          3.downto(1) do |i|
            $typingrace.each_participants { |user| user.send("#{i}...") }
            sleep(1)
          end

          $typingrace.start!

          Embed::Success.send(
            $typingrace.channel,
            [
              {
                name: ':checkered_flag:  La course a été lancée avec le texte suivant:',
                value: $typingrace.text[:content]
              }
            ]
          )
        else
          $typingrace.launch(event.channel, text)
          $typingrace.join(user)

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
