$:.unshift File.dirname(__FILE__)
require 'mechanize'
require 'currency_spy/scraper'
require 'currency_spy/nbp'

module CurrencySpy
  DATE_FORMAT = "%d-%m-%Y"

  def self.datestr(date)
    return date.strftime(CurrencySpy::DATE_FORMAT)
  end
end
