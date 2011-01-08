require 'spec_helper'

describe "A Scraper class" do
  it "Should have a list of available currency codes" do
    CurrencySpy::Scraper::AVAILABLE_CODES.should_not be_empty
  end
end

describe "An instance of scraper" do
  before :each do
    @scraper = CurrencySpy::Scraper.new
  end

  it "should raise an exception if fetch_rate is called on Scraper class instance" do
    lambda {@scraper.fetch_rates("XYZ")}.should raise_error(Exception, "This method should be invoked from CurrencySpy::Scraper sub class")
  end

  it "should raise an exception if an abstract method is called" do
    lambda {@scraper.buy_rate}.should raise_error(NotImplementedError)
    lambda {@scraper.sell_rate}.should raise_error(NotImplementedError)
    lambda {@scraper.rate_time}.should raise_error(NotImplementedError)
  end

  it "should allow to read the mechanize parser" do
    @scraper.parser.should_not be_nil
    @scraper.parser.should be_a_kind_of Mechanize
  end

  it "should assign default properties" do
    @scraper.url.should be_nil
  end
end
