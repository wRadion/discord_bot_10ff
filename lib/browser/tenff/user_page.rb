module Browser
  class Tenff

    class UserPage

      def initialize(browser)
        @browser = browser
        @html = fetch_html
      end

      def name
        @html.css('h2').text.squish.split[1..-1].join(' ')
      end

      def main_language
        sleep(1)
        Tenff.id_lang(
          fetch_html.css('#graph-flag-selection > a').first.attribute('speedtest_id').value
        )
      end

      def set_language(language)
        button = @browser.div(id: 'graph-flag-selection').as.find do |a|
          a.attribute('speedtest_id') == Tenff.lang_id(language).to_s
        end

        raise Tenff::NoScoresInLanguageError if button.nil?

        button.click!

        sleep(1)
      end

      def scores(type)
        {
          min: wpm(:min, type),
          avg: wpm(:avg, type),
          max: wpm(:max, type)
        }
      end

      def wpm(score, type)
        graph_scores.css('p').map(&:text)[index_wpm(score, type)].split.last.to_i
      end

      private

      def fetch_html
        @html = Nokogiri.HTML(@browser.html)
      end

      def graph_scores
        fetch_html.css('#graph-min-max-avg')
      end

      def index_wpm(score, type)
        case score
        when :min then 0
        when :avg then 1
        when :max then 2
        end + (type == :nor ? 0 : 3)
      end

    end

  end
end
