require_relative 'base'

module Commands
  module Type
    class Stop < Base

      def description
        'Arrête la course de dactylographie en cours.'
      end

      def usage
        '`?type stop`'
      end

      def argc
        [0]
      end

      def execute(event)
        'Stop!'
      end

    end
  end
end