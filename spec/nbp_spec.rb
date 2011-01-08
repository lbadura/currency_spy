require 'spec_helper'

describe "A Nbp scraper instance" do
  before :each do
    @scraper = CurrencySpy::Nbp.new
  end

  it "should have a proper url defined" do
    @scraper.url.should == 'http://www.nbp.pl/home.aspx?f=/kursy/kursyc.html'
  end

  it "should return currency values" do
    @scraper.fetch_rates.should_not be_nil
    @scraper.fetch_rates.length.should == 3
    @scraper.buy_rate.should == @scraper.fetch_rates[:buy_rate]
    @scraper.sell_rate.should == @scraper.fetch_rates[:sell_rate]
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
