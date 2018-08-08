module Commands
  module Type
    class Start

      def description
        'Démarre une course de dactylographie.'
      end

      def usage
        '?type start'
      end

      def argc
        [0]
      end

      def execute(event)
        'Start!'
      end

    end
  end
end
