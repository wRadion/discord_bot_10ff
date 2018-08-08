module Commands
  module User
    class List

      def description
        'Liste les utilisateurs enregistres dans la base.'
      end

      def usage
        '?user list [page=1]'
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

        limit = 25
        offset = (page - 1) * limit

        total_pages = (::User.count / limit.to_f).ceil

        if page.negative? || page > total_pages
          Embed::Error.send(event.channel, "Cette page n'existe pas.")
          return
        end

        users = ::User.limit(offset..(offset + limit))

        list = users.map do |user|
          "#{user[:id]} - **#{user[:name]}** (_[#{user[:tenff_name]}:#{user[:tenff_id]}](https://10fastfingers.com/user/#{user[:tenff_id]})_)"
        end.join("\n")

        Embed::Success.send(
          event.channel,
          [
            {
              name: ':ledger:  Liste des utilisateurs',
              value: list
            }
          ],
          { footer: { text: "Page #{page} sur #{total_pages}" } }
        )
      end

    end
  end
end
