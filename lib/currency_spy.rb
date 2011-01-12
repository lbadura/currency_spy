$:.unshift File.dirname(__FILE__)
require 'mechanize'
require 'currency_spy/scraper'

scrapers = %w(nbp walutomat dnb_nord)
scrapers.each do |scraper|
  require "currency_spy/#{scraper}"
end

module CurrencySpy
  DATE_FORMAT = "%d-%m-%Y"

  def self.datestr(date)
    return date.strftime(CurrencySpy::DATE_FORMAT)
  end
end
