require 'rspec'
require 'currency_spy'

shared_examples_for 'a valid scraper' do
  it "should contain a list of available currency codes" do
    scraper.available_codes.should_not be_nil
  end

  it "should have a data url defined" do
    scraper.url.should_not be_nil
  end

  it "should have an institution name" do
    scraper.institution.should_not be_nil
  end

  it "should return currency rates" do
    scraper.fetch_rates.should_not be_empty
  end
end
