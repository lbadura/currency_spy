$:.unshift File.dirname(__FILE__)
require 'mechanize'
require 'currency_spy/scraper'

scrapers = %w(nbp walutomat dnb_nord mbank)
scrapers.each do |scraper|
  require "currency_spy/#{scraper}"
end

# This gem is a set of scrapers to fetch currencies from various
# institutions' websites. It's primary use is to monitor the changes of
# currency rates across different institutions to calculate spreads (difference
# between the buying rate and the selling rate. It fetches the rates in PLN
# (Polish Zloty) however if there's a demand I could extend the gem to be more
# flexible.
#
# Author::    Łukasz Badura  (mailto:lukasz@niebo.net)
# Copyright:: Copyright (c) 2011 Łukasz Badura
# License::   MIT license.
module CurrencySpy
  # Default date format used for date presentation across the code
  DATE_FORMAT = "%d-%m-%Y"

  # Returns a string representation of a given date in the default format
  def self.datestr(date)
    return date.strftime(CurrencySpy::DATE_FORMAT)
  end
end
