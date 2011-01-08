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
    @scraper.buy_rate.should == @scraper.fetch_rates[0]
    @scraper.sell_rate.should == @scraper.fetch_rates[1]
    @scraper.rate_time.should == @scraper.fetch_rates[2]
  end
end
