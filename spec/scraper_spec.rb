require 'spec_helper'

describe "A Scraper class" do
  it "Should have a list of available currency codes" do
    CurrencySpy::Scraper::AVAILABLE_CODES.should_not be_empty
  end
end

describe "A plain instance of scraper" do
  before :each do
    @scraper = CurrencySpy::Scraper.new
  end

  it "should raise an exception if fetch_rate is called on Scraper class instance" do
    lambda {@scraper.fetch_rates("XYZ")}.should raise_error(Exception, "This method should be invoked from CurrencySpy::Scraper sub class")
  end

  it "should not parse any pages" do
    @scraper.page.should be_nil
  end

  it "should assign default properties" do
    @scraper.url.should be_nil
  end
end

describe "An instance of a scraper with an URI" do
  before :each do
    @scraper = CurrencySpy::Scraper.new
    @scraper.url = 'http://www.google.com'
  end

  it "should return a Mechanize::Page instance on a call to page" do
    @scraper.page.should_not be_nil
    @scraper.page.should be_a_kind_of Mechanize::Page
  end

  it "should reload the page object if necessary" do
    cached = @scraper.page
    @scraper.page.should equal cached
    @scraper.page(reload = true).should_not equal cached
  end
end
