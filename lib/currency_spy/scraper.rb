module CurrencySpy
  class Scraper
    AVAILABLE_CODES = ['EUR', 'CHF', 'GBP'].freeze
    attr_accessor :url, :currency_code
    attr_reader :available_codes, :parser
    def initialize(currency_code = 'EUR')
      @currency_code = currency_code
      @parser = Mechanize.new
      @url = nil
    end

    def fetch_for_code(currency_code)
      if AVAILABLE_CODES.include?(currency_code)
        @currency_code = currency_code
        return [current_buy_rate, current_sell_rate, current_rate_time]
      else
        raise Exception.new("Unsupported currency code: #{currency_code}")
      end
    end

    protected
    def buy_rate
      # This method should be defined in a sub class
      raise NotImplementedError
    end

    def sell_rate
      # This method should be defined in a sub class
      raise NotImplementedError
    end

    def rate_time
      # This method should be defined in a sub class
      raise NotImplementedError
    end
  end
end
