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
        "List! #{page}"
      end

    end
  end
end
