module CurrencySpy
  class Nbp < CurrencySpy::Scraper

    def initialize
      super
      @url = 'http://www.nbp.pl/home.aspx?f=/kursy/kursyc.html'
      @page = parser.get(url)
      @institution = "Narodowy Bank Polski"
    end

    def buy_rate(currency_code = nil)
      currency_code = @currency_code ||= 'EUR'
      regexp = Regexp.new(currency_code)
      @page.search('//tr[@valign="middle"]').each do |tr|
        tr.search('td').each do |td|
          if (regexp.match(td.content))
            return td.next_element.content.sub(',','.').to_f
          end
        end
      end
      return nil
    end

    def sell_rate(currency_code = nil)
      currency_code = @currency_code ||= 'EUR'
      regexp = Regexp.new(currency_code)
      @page.search('//tr[@valign="middle"]').each do |tr|
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
      @page.search('//p[@class="nag"]').each do |p|
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
