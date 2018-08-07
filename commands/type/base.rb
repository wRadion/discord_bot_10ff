module Commands
  module Type
    class Base

      def description
        raise NotImplementedError
      end

      def usage
        raise NotImplementedError
      end

      def argc
        nil
      end

      def execute(event, *args)
        raise NotImplementedError
      end

    end
  end
end
