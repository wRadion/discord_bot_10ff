module Commands
  module User
    class Del

      def description
        'Supprime un utilisateur de la base.'
      end

      def usage
        '?user del <id>'
      end

      def argc
        [1]
      end

      def execute(event, user_id)
        if !(user_id =~ /\d+/)
          Embed::Error.send(event.channel, "L'id doit être un nombre entier.")
          return
        end
        user_id = user_id.to_i

        user = ::User[user_id]

        if user.nil?
          Embed::Error.send(event.channel, "Aucun utilisateur trouvé ayant pour id `#{user_id}`.")
          return
        end

        ::Text.where(user_id: user[:id]).delete
        ::TextScore.where(user_id: user[:id]).delete
        ::Quiz.where(user_id: user[:id]).delete

        user.delete

        Embed::Success.send(
          event.channel,
          [
            {
              name: ':boom:  Utilisateur supprimé',
              value: "L'utilisateur `#{user[:name]}` a été supprimé avec succès. Cela a également eu pour effet de supprimer les textes, les quiz et les records de l'utilisateur."
            }
          ]
        )
      end

    end
  end
end
