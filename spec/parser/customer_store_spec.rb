# frozen_string_literal: true

require "parser"
require "processor"

RSpec.describe Parser::CustomerStore do
  let(:customer_factory) { instance_double(Processor::CustomerFactory) }


  describe '.load_file' do
    context "creates customer store" do
      before do
        allow(customer_factory).to receive(:build).with({ "latitude": "53.521111", "name": "Enid Enright", "user_id": 3, "longitude": "-9.831111" })
        allow(customer_factory).to receive(:build).with({ "latitude": "53.2451022", "user_id": 2, "name": "Ian Kehoe", "longitude": "-6.238335" })
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

  describe '#nearby' do
    let(:customer1) {instance_double(Processor::Customer, { name: "Enid Enright", id: 3, distance_to: 237.58} )}
    let(:customer2) {instance_double(Processor::Customer, {  id: 2, name: "Ian Kehoe", distance_to: 10.57} )}
    let(:customer3) {instance_double(Processor::Customer, { id: 1, name: "Charlie McArdle", distance_to: 180.16} )}
    let(:customer4) {instance_double(Processor::Customer, { id: 6, name: "Theresa Enright", distance_to: 24.09} )}
    

    let(:origin) { instance_double(Processor::Coordinate, {latitude: 53.339428, longitude: -6.257664}) }
    let(:distance) { 100 }

    it 'gets customer with specified distance' do
      customers = Parser::CustomerStore.new([customer1, customer2, customer3, customer4])
      nearby_customers = customers.nearby(origin, distance)
      expect(nearby_customers).to include(customer4)
      expect(nearby_customers.size).to eql(2)
      expect(nearby_customers.first).to eql(customer2)
    end
  end
end
