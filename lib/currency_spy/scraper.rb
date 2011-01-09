module CurrencySpy
  class Scraper
    AVAILABLE_CODES = ['EUR', 'CHF', 'GBP'].freeze
    RATES = %w(buy_rate sell_rate medium_rate rate_time).freeze
    attr_accessor :currency_code, :url
    attr_reader :available_codes, :parser, :institution
    def initialize()
      @url = nil
    end

    def page(reload = false)
      return nil if @url.nil?
      unless reload
        @page ||= Mechanize.new.get(@url)
      else
        @page = Mechanize.new.get(@url)
      end
      return @page
    end

    def fetch_rates(currency_code = 'EUR')
      if self.class.superclass.eql?(Object)
        raise Exception.new("This method should be invoked from CurrencySpy::Scraper sub class")
      else
        if AVAILABLE_CODES.include?(currency_code)
          @currency_code = currency_code
          response = {}
          RATES.each do |rate|
            symbol = rate.to_sym
            if self.class.instance_methods.include?(symbol)
              value = self.send(symbol)
              response[symbol] = value unless value.nil?
            end
          end
          return response
        else
          raise Exception.new("Unsupported currency code: #{currency_code}")
        end
      end
    end

    
  end
end
