module Commands
  module Type
    class List

      def description
        'Liste tous les textes présents dans la base des textes'
      end

      def usage
        '?type list [page=1]'
      end

      def argc
        [0, 1]
      end

      def execute(event, page = '1')
        if !(page =~ /\d+/)
          Embed::Error.send(event.channel, "Le numéro de page doit être un nombre entier.")
          return
        end
        page = page.to_i

        limit = PAGINATION_LIMIT
        offset = (page - 1) * limit

        total_pages = (::Text.count / limit.to_f).ceil

        if total_pages.zero?
          Embed::Success.send(
            event.channel,
            [
              {
                name: ':notepad_spiral:  Liste des textes',
                value: 'Aucun texte dans la base.'
              }
            ]
          )
          return
        end

        if page.negative? || page > total_pages
          Embed::Error.send(event.channel, "Cette page n'existe pas.")
          return
        end

        texts = ::Text.limit(offset..(offset + limit))

        authors = ''
        list = texts.map do |text|
         authors << "**#{text.user[:name]}**\n"
          "**#{text[:id]}** - _#{text[:content].truncate(30)}_"
        end.join("\n")

        Embed::Success.send(
          event.channel,
          [
            {
              name: ':notepad_spiral:  Liste des textes',
              value: list,
              inline: true
            },
            {
              name: ':pen_fountain:  Ajouté par',
              value: authors,
              inline: true
            }
          ],
          { footer: { text: "Page #{page} sur #{total_pages}" } }
        )
      end

    end
  end
end
