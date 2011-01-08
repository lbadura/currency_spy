module CurrencySpy
  class Nbp < CurrencySpy::Scraper

    def initialize
      super
      @url = 'http://www.nbp.pl/home.aspx?f=/kursy/kursyc.html'
      @page = parser.get(url)
    end

    def buy_rate
      regexp = Regexp.new(@currency_code)
      @page.search('//tr[@valign="middle"]').each do |tr|
        tr.search('td').each do |td|
          if (regexp.match(td.content))
            return td.next_element.content.sub(',','.').to_f
          end
        end
      end
      return nil
    end

    def sell_rate
      regexp = Regexp.new(@currency_code)
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
    end

  end
end
