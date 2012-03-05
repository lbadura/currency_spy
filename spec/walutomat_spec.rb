require 'spec_helper'

describe "A Walutomat scraper instance" do
  let(:scraper) { CurrencySpy::Walutomat.new }

  it_should_behave_like 'a valid scraper'

  it "should return the name of the institution" do
    scraper.institution.should == "Walutomat"
  end

  it "should have a proper url defined" do
    scraper.url.should == 'http://www.walutomat.pl/rates.php'
  end

  it "should return 2 currency values" do
    scraper.fetch_rates.length.should == 2
  end

  it "should return rate time as a DateTime instance" do
    scraper.fetch_rates[:rate_time].should be_a_kind_of(DateTime)
  end

  describe 'medium rate' do
    it 'returned by a call to medium rate' do
      scraper.medium_rate.should == scraper.fetch_rates[:medium_rate]
    end

    it "should return a medium rate as a float" do
      scraper.fetch_rates[:medium_rate].should be_a_kind_of(Float)
    end
  end
end
