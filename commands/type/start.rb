require_relative 'base'

module Commands
  module Type
    class Start < Base

      def description
        'Démarre une course de dactylographie.'
      end

      def usage
        '`?type start`'
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
