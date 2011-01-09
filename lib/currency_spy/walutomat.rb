module CurrencySpy
  class Walutomat < CurrencySpy::Scraper

    def initialize
      super
      @url = 'http://www.walutomat.pl/rates.php'
      @institution = 'Walutomat'
    end

    def medium_rate
      regexp = Regexp.new(currency_code)
      return 1.0
    end

    def rate_time
      regexp = Regexp.new(/\d\d\d\d-\d\d-\d\d/)
      res = nil
      page.search('//p[@class="nag"]').each do |p|
        p.search('b').each do |b|
          if (regexp.match(b.content))
            res = b.content
          end
        end
      end
      return DateTime.new
    end
    
  end
end
