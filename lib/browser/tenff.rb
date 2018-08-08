require 'nokogiri'
require 'selenium/webdriver'
require 'watir'

require_relative '../../ext/string'
require_relative 'tenff/user_page'

module Browser
  class Tenff

    class UserNotFoundError < StandardError; end
    class NoScoresInLanguageError < StandardError; end

    def self.lang_id(lang)
      @@ids ||= JSON.parse(File.read('./config/language_10ff.json'))

      @@ids[lang.to_s]
    end

    def self.id_lang(id)
      @@ids ||= JSON.parse(File.read('./config/language_10ff.json'))

      @@ids.key(id.to_i)
    end

    def self.lang_flag(lang)
      @@flags ||= JSON.parse(File.read('./config/flag_10ff.json'))

      @@flags[lang.to_s]
    end

    def initialize
      driver = Selenium::WebDriver.for(
        :chrome,
        url: 'http://localhost:9515',
        options: chrome_options
      )

      @browser = Watir::Browser.new(driver)
    end

    def fetch_user_info(user_id, lang = nil)
      if user_id =~ /[a-zA-Z_]/
        user = User.where(name: user_id).first

        raise UserNotFoundError if user.nil?

        user_id = user[:tenff_id].to_s
      end

      @browser.goto("https://10fastfingers.com/user/#{user_id}")

      raise UserNotFoundError if @browser.url.include?('typing-test')

      user = UserPage.new(@browser)
      main = user.main_language

      if lang == 'main'
        lang = main
      elsif lang != nil
        user.set_language(lang)
      end

      infos = { link: @browser.url, name: user.name, main: lang == main }
      infos[lang] = { nor: user.scores(:nor), adv: user.scores(:adv) } unless lang.nil?
      infos
    end

    private

    def chrome_options
      Selenium::WebDriver::Chrome::Options.new.tap do |opts|
        opts.add_argument('--no-sandbox')
        opts.add_argument('--headless') if ENV.fetch('HEADLESS', 'true') == 'true'
      end
    end

  end
end
