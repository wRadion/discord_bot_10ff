module Commands
  module Type
    class Join

      def description
        'Permet de rejoindre une course.'
      end

      def usage
        Commands::Type::JOIN_USAGE
      end

      def argc
        [0]
      end

      def execute(event)
      end

    end
  end
end
