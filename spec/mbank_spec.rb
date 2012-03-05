require 'spec_helper'

describe "mBank scraper instance" do
  let(:scraper) { CurrencySpy::Mbank.new }

  it_should_behave_like 'a valid scraper'

  it "should introduce itself" do
    scraper.institution.should == "mBank"
  end

  it "should have url set to mBank website" do
    scraper.url.should == 'http://www.mbank.pl/informacja/kursy-walut.html'
  end
end
