module CurrencySpy
  class Mbank < CurrencySpy::ScraperBase
    attr_accessor :session_date, :session_no

    def initialize
      super
      @url = nil
      @institution = 'mBank'
      @available_codes = %w(AUD CAD CHF CZK DKK EUR GBP HUF JPY NOK SEK USD)
      @session_no = nil
    end

    def url
      'http://www.mbank.pl/informacja/kursy-walut.html'
    end

  end
end
