module Commands
  module Type
    class Stop

      def description
        'Arrête la course de dactylographie en cours.'
      end

      def usage
        '?type stop'
      end

      def argc
        [0]
      end

      def execute(event)
        if $typingrace.launched?
          $typingrace.reset!

          Embed::Success.send(
            event.channel,
            [
              {
                name: ':stop_sign:  Course arrêtée',
                value: 'La course a été abandonnée.'
              }
            ]
          )
        elsif !$typingrace.started?
          Embed::Error.send(event.channel, "Il n'y a aucune course en cours.")
        else
          $typingrace.stop

          Embed::Success.send(
            event.channel,
            [
              {
                name: ':stop_sign:  Course arrêtée',
                value: 'La course a été arrêtée.'
              }
            ]
          )
        end
      end

    end
  end
end
