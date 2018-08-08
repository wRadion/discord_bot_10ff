require_relative 'base'

module Commands
  module Type
    class Add < Base

      def description
        'Ajoute un texte dans la base des textes.'
      end

      def usage
        '`?type add <texte>`'
      end

      def execute(event, *args)
        user = User.find_or_error(event)
        text = args.join(' ')

        Text.create(
          user_id: User.where(user_id: user.id).id,
          content: text
        )

        Embed::Success.send(
          event.channel,
          [
            { name: ':white_check_mark:  Texte ajouté !', value: text }
          ],
          { footer: EmbedFooter.new(text: user.name) }
        )
      end

    end
  end
end
