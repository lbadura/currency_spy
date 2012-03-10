require 'spec_helper'

describe "mBank scraper instance" do
  let(:scraper) { CurrencySpy::Mbank.new }

  it_should_behave_like 'a valid scraper'

  specify {scraper.institution.should == 'mBank'}
  specify {scraper.url.should == 'http://www.mbank.pl/informacja/kursy-walut.html'}
  specify {scraper.sell_rate.should_not be_nil}
  specify {scraper.buy_rate.should_not be_nil}
end
