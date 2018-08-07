require_relative 'base'

module Commands
  module Type
    class List < Base

      def description
        'Liste tous les textes présents dans la base des textes'
      end

      def usage
        '`?type list [page=1]`'
      end

      def argc
        [0, 1]
      end

      def execute(event, page = 0)
        "List! #{page}"
      end

    end
  end
end
