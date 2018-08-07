require_relative 'base'

module Commands
  module Type
    class Del < Base

      def description
        'Supprime un texte de la base des textes.'
      end

      def usage
        '`?type del <id texte>`'
      end

      def argc
        [1]
      end

      def execute(event, text_id)
        "Del! #{text_id}"
      end

    end
  end
end
