module CurrencySpy
  # A base class for all scrapers. Defines the common logic which
  # is used across all of them.
  class ScraperBase
    # Holds all data which is being fetched by the scrapers.
    
    # Each item has to be implemented as a method in the scraper sub class.
    RATE_DATA = %w(buy_rate sell_rate medium_rate rate_time).freeze

    # current currency code we're fetching rates for
    attr_accessor :currency_code
    # url of the source web page
    attr_accessor :url
    # a list of codes available from given source
    attr_reader :available_codes
    # name of the source institution
    attr_reader :institution

    # Base constructor
    def initialize()
      @url = nil
      @currency_code = 'EUR'
    end

    # Returns a Mechanize::Page instance which is the being searched on.
    # If the page was once fetched it's reuse. To reload, call with an argument
    # evaluating to true.
    def page(reload = false)
      return nil if   url.nil?
      unless reload
        @page ||= Mechanize.new.get(url)
      else
        @page = Mechanize.new.get(url)
      end
      return @page
    end

    # Method which calls all rate fetching methods from the sub class and returns
    # a Hash with appropriate values.
    def fetch_rates
      if self.class.superclass.eql?(Object)
        raise Exception.new("This method should be invoked from CurrencySpy::Scraper sub class")
      else
        check_currency_code_validity
        response = {}
        RATE_DATA.each do |rate|
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
    # Helper method to check if a given source provides (supports) information
    # about given currency.
    def check_currency_code_validity
      if available_codes.include?(currency_code)
        return true
      else
        raise Exception.new("Unsupported currency code: #{currency_code}")
      end
    end
  end
end
