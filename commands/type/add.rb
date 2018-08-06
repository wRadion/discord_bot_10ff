module Commands
  module Type
    class Add < Base

      def description
        'Ajoute un texte dans la base des textes.'
      end

      def usage
        '<text>'
      end

      def execute(event, *args)
        user = find_user(event)
        text = args.join(' ')

        Text.create(
          user_id: User.where(user_id: user.id).id,
          content: text
        )
      end

    end
  end
end
