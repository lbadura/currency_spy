module CurrencySpy
  class Scraper
    AVAILABLE_CODES = ['EUR', 'CHF', 'GBP'].freeze
    attr_accessor :url, :currency_code
    attr_reader :available_codes, :parser
    def initialize()
      @parser = Mechanize.new
      @url = nil
    end

    def fetch_rates(currency_code = 'EUR')
      if self.class.superclass.eql?(Object)
        raise Exception.new("This method should be invoked from CurrencySpy::Scraper sub class")
      else
        if AVAILABLE_CODES.include?(currency_code)
          @currency_code = currency_code
          return {:buy_rate => buy_rate, :sell_rate => sell_rate, :rate_time => rate_time}
        else
          raise Exception.new("Unsupported currency code: #{currency_code}")
        end
      end
    end

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
