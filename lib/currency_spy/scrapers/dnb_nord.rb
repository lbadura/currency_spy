module CurrencySpy
  # Class designed to fetch data from DnB Nord's website.
  class DnbNord < CurrencySpy::ScraperBase

    attr_accessor :session_date, :session_no

    # Constructor. Initializes the following:
    # * url is set to nil
    # * institution name
    # * a list of currency codes available from that source
    # * session_no number of the session. There are two sessions. 1 means the first at 8:15 am and 2 means the second one held at 12:15
    def initialize
      super
      @url = nil
      @institution = 'DnB Nord'
      @available_codes = %w(EUR USD GBP CHF DKK NOK SEK CZK JPY HUF CAD AUD LTL)
      @session_no = nil
    end

    # Determines the correct url of the web page to fetch rates from based of the instance variable session_no
    def url
      dnb_session_no = @session_no ||= 1
      session_time = dnb_session_no == 2 ? "12:15" : "08:15"
      return "http://www.dnbnord.pl/pl/tabela-kursow-walut-dla-kredytow/go:godzina=#{session_time}"
    end

    # Fetches the selling rate
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

    # Fetches the buying rate
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

    # Fetches the time of given rates
    def rate_time
      hour = @session_time == 2 ? "12:15" : "08:15"
      DateTime.parse(hour)
    end
  end
end
