module CurrencySpy
  class Scraper
    RATES = %w(buy_rate sell_rate medium_rate rate_time).freeze
    attr_accessor :currency_code, :url
    attr_reader :available_codes, :parser, :institution
    def initialize()
      @url = nil
      @currency_code = 'EUR'
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

    def fetch_rates
      if self.class.superclass.eql?(Object)
        raise Exception.new("This method should be invoked from CurrencySpy::Scraper sub class")
      else
        check_currency_code_validity
        response = {}
        RATES.each do |rate|
          symbol = rate.to_sym
          if self.class.instance_methods.include?(symbol)
            value = self.send(symbol)
            response[symbol] = value unless value.nil?
          end
        end
        return response
      end
    end

    protected
    def check_currency_code_validity
      if available_codes.include?(currency_code)
        return true
      else
        raise Exception.new("Unsupported currency code: #{currency_code}")
      end
    end
  end
end
