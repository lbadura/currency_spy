module CurrencySpy
  # A class designed to fetch medium currency rates from Walutomat.pl a social currency exchange platform.
  class Walutomat < CurrencySpy::ScraperBase

    # Constructor method.
    # Initializes the following:
    # * a url of the source
    # * and the name of the source
    # * a list of currency codes available
    def initialize
      super
      @url = 'http://www.walutomat.pl/rates.php'
      @institution = 'Walutomat'
      @available_codes = %w(EUR USD GBP CHF)
    end

    # Fetch medium rate which is calculated based on current transactions in Walutomat
    def medium_rate
      regexp = Regexp.new("#{currency_code} / PLN")
      res = nil
      page.search("//span[@name='pair']").each do |td|
        if (regexp.match(td.content))
          res = td.next_element.content.to_f
        end
      end
      return res
    end

    # The hour of the rate
    def rate_time
      regexp = Regexp.new(currency_code)
      res = nil
      page.search("//span[@name='pair']").each do |td|
        if (regexp.match(td.content))
          hour = td.next_element.next_element.content
          res = DateTime.parse(hour)
        end
      end
      return res
    end
  end
end
