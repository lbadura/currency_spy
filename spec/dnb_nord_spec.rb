require 'spec_helper'

describe "A DnbNord scraper instance" do
  before :each do
    @scraper = CurrencySpy::DnbNord.new
  end

  it "should return the name of the institution" do
    @scraper.institution.should == "DnB Nord"
  end

  it "should have a proper url defined" do
    @scraper.session_no = 1
    @scraper.url.should == 'http://www.dnbnord.pl/pl/tabela-kursow-walut-dla-kredytow/go:godzina=08:15'
    @scraper.session_no = 2
    @scraper.url.should == 'http://www.dnbnord.pl/pl/tabela-kursow-walut-dla-kredytow/go:godzina=12:15'
  end

  it "should contain a list of available currency codes" do
    @scraper.available_codes.should_not be_nil
  end

  it "should return currency values" do
    @scraper.session_no = 1
    @scraper.fetch_rates.should_not be_nil
    @scraper.fetch_rates.length.should == 3
    @scraper.buy_rate.should == @scraper.fetch_rates[:buy_rate]
    @scraper.sell_rate.should == @scraper.fetch_rates[:sell_rate]
    @scraper.rate_time.should == @scraper.fetch_rates[:rate_time]
  end

  it "should return a buy rate smaller than the sell rate" do
    @scraper.buy_rate.should < @scraper.sell_rate
  end

  it "should return buy rate as a float" do
    @scraper.fetch_rates[:buy_rate].should be_a_kind_of(Float)
  end

  it "should return sell rate as a float" do
    @scraper.fetch_rates[:sell_rate].should be_a_kind_of(Float)
  end

  it "should return rate time as a DateTime instance" do
    @scraper.fetch_rates[:rate_time].should be_a_kind_of(DateTime)
  end
end
