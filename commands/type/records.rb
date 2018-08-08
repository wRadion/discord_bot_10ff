module Commands
  module Type
    class Records

      def description
        "Affiche les records d'un utilisateur (ou de vous) sur un texte (ou général)."
      end

      def usage
        '?type records [user id] [text id]'
      end

      def argc
        [0, 1, 2]
      end

      def execute(event, user_id = nil, text_id = nil)
        if !user_id.nil? && !(user_id =~ /\d+/)
          Embed::Error.send(event.channel, "L'id de l'utilisateur doit être un nombre entier.")
          return
        end
        user = (user_id.nil? || user_id == '0') ? ::User.find_or_error(event) : ::User[user_id.to_i]

        if user.nil?
          Embed::Error.send(event.channel, "Aucun utilisateur trouvé avec pour id `#{text_id}`.")
          return
        end

        if !text_id.nil? && !(text_id =~ /\d+/)
          Embed::Error.send(event.channel, "L'id du texte doit être un nombre entier.")
          return
        end
        texts = text_id.nil? ? ::Text.all : Array.wrap(::Text[text_id.to_i])

        if texts.first.nil?
          Embed::Error.send(event.channel, "Aucun texte trouvé avec pour id `#{text_id}`.")
          return
        end

        scores = ::TextScore.where(user_id: user[:id], text_id: texts.map { |t| t[:id] })

        records = scores.order(Sequel.desc(:wpm)).map do |score|
          "__Text:__ #{score[:text_id]} | **#{score[:wpm]} MPM** | #{score[:date].strftime("%D")}"
        end

        Embed::Success.send(
          event.channel,
          [
            {
              name: ":keyboard:  Records de #{user[:name]}",
              value: records.empty? ? '_Aucun record._' : records.join("\n")
            }
          ]
        )
      end

    end
  end
end
