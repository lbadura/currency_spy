module CurrencySpy
  class DnbNord < CurrencySpy::Scraper

    attr_accessor :session_date, :session_no
    def initialize
      super
      @url = nil
      @institution = 'DnB Nord'
      @available_codes = %w(EUR USD GBP CHF DKK NOK SEK CZK JPY HUF CAD AUD LTL)
      @session_date = nil
      @session_no = nil
    end

    def url
      dnb_session_no = @session_no ||= 1
      session_time = dnb_session_no == 2 ? "12:15" : "08:15"
      return "http://www.dnbnord.pl/pl/tabela-kursow-walut-dla-kredytow/go:godzina=#{session_time}"
    end

    def sell_rate
      regexp = Regexp.new(currency_code)
      res = nil
      page.search("//td").each do |td|
        if (regexp.match(td.content))
          res = td.next_element.next_element.content.to_f
        end
      end
      return res
    end

    def buy_rate
      regexp = Regexp.new(currency_code)
      res = nil
      page.search("//td").each do |td|
        if (regexp.match(td.content))
          res = td.next_element.content.to_f
        end
      end
      return res
    end

    def rate_time
      hour = @session_time == 2 ? "12:15" : "08:15"
      DateTime.parse(hour)
    end
  end
end
