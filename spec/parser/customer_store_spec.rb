# frozen_string_literal: true

require "parser"
require "processor"

RSpec.describe Parser::CustomerStore do
  let(:customer_factory) { instance_double(Processor::CustomerFactory) }

  context "creates customer store" do
    before do
      allow(customer_factory).to receive(:build).with({ "latitude" => "53.521111", "name" => "Enid Enright", "user_id" => 3, "longitude" => "-9.831111" })
      allow(customer_factory).to receive(:build).with({ "latitude": "51.802", "user_id": 2, "name": "David Ahearn", "longitude": "-9.442" })
      allow(customer_factory).to receive(:build).with({ "latitude": "54.374208", "user_id": 1, "name": "Charlie McArdle", "longitude": "-8.371639" })
      allow(customer_factory).to receive(:build).with({ "latitude": "53.1229599", "user_id": 6, "name": "Theresa Enright", "longitude": "-6.2705202" })
    end

    it "when input txt file passed" do
      customer_store = Parser::CustomerStore.load_file("spec/test_data/test.txt", customer_factory)
      expect(customer_store).to be_a(Parser::CustomerStore)
    end
  end

  it "raises error on empty or missing key" do
    allow(customer_factory).to receive(:build).with({ "latitude" => "153.521111", "name" => "Enid Enright", "user_id" => 3, "longitude" => "-9.831111" }).and_raise
    expect { Parser::CustomerStore.load_file("spec/test_data/test.txt", customer_factory) }.to raise_error
  end
end
