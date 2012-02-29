require 'spec_helper'

describe "A DnbNord scraper instance" do
  let(:scraper) { CurrencySpy::DnbNord.new }

  shared_examples_for "a scraper instance" do
    subject { scraper }

    its(:fetch_rates) { should_not be_nil } 
    its(:available_codes) { should_not be_nil }
    its(:institution) { should == 'DnB Nord' }
  end

  context "for first session" do
    before { scraper.session_no = 1 }
    subject { scraper }

    it_should_behave_like "a scraper instance"
    its(:url) { should == 'http://www.dnbnord.pl/pl/tabela-kursow-walut-dla-kredytow/go:godzina=08:15' }
  end

  context "for the second session" do 
    before { scraper.session_no = 2 }
    subject { scraper }

    it_should_behave_like "a scraper instance"
    its(:url) { should == 'http://www.dnbnord.pl/pl/tabela-kursow-walut-dla-kredytow/go:godzina=12:15' }
  end

  it "should return a buy rate smaller than the sell rate" do
    scraper.buy_rate.should < scraper.sell_rate
  end

  it "should return buy rate as a float" do
    scraper.fetch_rates[:buy_rate].should be_a_kind_of(Float)
  end

  it "should return sell rate as a float" do
    scraper.fetch_rates[:sell_rate].should be_a_kind_of(Float)
  end

  it "should return rate time as a DateTime instance" do
    scraper.fetch_rates[:rate_time].should be_a_kind_of(DateTime)
  end
end
