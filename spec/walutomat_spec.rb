require 'spec_helper'

describe "A Walutomat scraper instance" do
  before :each do
    @scraper = CurrencySpy::Walutomat.new
  end

  it "should return the name of the institution" do
    @scraper.institution.should == "Walutomat"
  end

  it "should have a proper url defined" do
    @scraper.url.should == 'http://www.walutomat.pl/rates.php'
  end

  it "should return currency values" do
    @scraper.fetch_rates.should_not be_nil
    @scraper.fetch_rates.length.should == 2
    @scraper.medium_rate.should == @scraper.fetch_rates[:medium_rate]
  end

  it "should return a medium rate as a float" do
    @scraper.fetch_rates[:medium_rate].should be_a_kind_of(Float)
  end

  it "should return rate time as a DateTime instance" do
    @scraper.fetch_rates[:rate_time].should be_a_kind_of(DateTime)
  end
end
