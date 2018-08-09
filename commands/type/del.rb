module Commands
  module Type
    class Del

      def description
        'Supprime un texte de la base des textes.'
      end

      def usage
        '?type del <id texte>'
      end

      def argc
        [1]
      end

      def execute(event, text_id)
        if !(text_id =~ /\d+/)
          Embed::Error.send(event.channel, "L'id doit être un nombre entier.")
          return
        end
        text_id = text_id.to_i

        text = ::Text[text_id]

        if text.nil?
          Embed::Error.send(event.channel, "Aucun texte trouvé ayant pour id `#{text_id}`.")
          return
        end

        ::TextScore.where(text_id: text[:id]).delete

        text.delete

        Embed::Success.send(
          event.channel,
          [
            {
              name: ':boom:  Texte supprimé',
              value: "Le texte `#{text[:content].truncate(50)}` a été supprimé avec succès."
            }
          ]
        )
      end

    end
  end
end
