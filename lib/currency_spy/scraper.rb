module CurrencySpy
  require 'mechanize'
  class Scraper
    attr_accessor :url, :currency_code, :page, :available_codes
    def initialize(currency_code = 'EUR')
      @currency_code = currency_code
      @parser = Mechanize.new
      @url = nil
      @available_codes = ['EUR', 'CHF'].freeze
    end

    def current_rate
      raise CurrentSpy::NotImplementedException
    end

    def rate_time
      raise CurrentSpy::NotImplementedException
    end

    def fetch_for_code(currency_code)
      @currency_code = currency_code
      return [current_buy_rate, current_sell_rate, current_rate_time]
    end
  end
end