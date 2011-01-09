module CurrencySpy
  class Nbp < CurrencySpy::Scraper

    def initialize
      super
      @url = 'http://www.nbp.pl/home.aspx?f=/kursy/kursyc.html'
      @institution = "Narodowy Bank Polski"
      @available_codes = %w(EUR USD GBP CHF AUS AUD CAD CZK DKK NOK SEK)
    end

    def buy_rate
      regexp = Regexp.new(currency_code)
      page.search('//tr[@valign="middle"]').each do |tr|
        tr.search('td').each do |td|
          if (regexp.match(td.content))
            return td.next_element.content.sub(',','.').to_f
          end
        end
      end
      return nil
    end

    def sell_rate
      regexp = Regexp.new(currency_code)
      page.search('//tr[@valign="middle"]').each do |tr|
        tr.search('td').each do |td|
          if (regexp.match(td.content))
            return td.next_element.next_element.content.sub(',','.').to_f
          end
        end
      end
      return nil
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
      return DateTime.strptime(res, "%Y-%m-%d")
    end
    
  end
end
