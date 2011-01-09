module CurrencySpy
  class Walutomat < CurrencySpy::Scraper

    def initialize
      super
      @url = 'http://www.walutomat.pl/rates.php'
      @institution = 'Walutomat'
      @available_codes = %w(EUR USD GBP CHF)
    end

    def medium_rate
      regexp = Regexp.new("#{currency_code} / PLN")
      res = nil
      page.search("//td[@name='pair']").each do |td|
        if (regexp.match(td.content))
          res = td.next_element.content.to_f
        end
      end
      return res
    end

    def rate_time
      regexp = Regexp.new(currency_code)
      time_regexp = Regexp.new(/\d+:\d+/)
      res = nil
      page.search("//td[@name='pair']").each do |td|
        if (regexp.match(td.content))
          hour = td.next_element.next_element.content
          res = DateTime.parse(hour)
        end
      end
      return res
    end
  end
end
