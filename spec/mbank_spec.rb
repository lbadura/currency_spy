require 'spec_helper'

describe "mBank scraper instance" do
  let(:scraper) { CurrencySpy::Mbank.new }

  it "should return it's institution name" do
    scraper.institution.should == "mBank"
  end

  it "should have a data url defined" do
    scraper.url.should == 'http://www.mbank.pl/informacja/kursy-walut.html'
  end

  it "should contain a list of available currency codes" do
    scraper.available_codes.should_not be_nil
  end
end
