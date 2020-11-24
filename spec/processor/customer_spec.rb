# frozen_string_literal: true

require "processor"

RSpec.describe Processor::Customer do
  let(:customer1) { Processor::Customer.new(1, "Charlie McArdle", customer1_location) }
  let(:customer2) { Processor::Customer.new(2, "Ian Kehoe", customer2_location) }

  let(:customer1_location) { instance_double(Processor::Coordinate, distance_to: 180.16)}
  let(:customer2_location) { instance_double(Processor::Coordinate, distance_to: 10.57)}

  let(:origin) { instance_double(Processor::Coordinate, {latitude: 53.339428, longitude: -6.257664}) }

  describe '#distance_to' do
    it 'gets distance of customer1 from origin' do
      expect(customer1_location).to receive(:distance_to).with(origin)
      expect(customer1.distance_to(origin)).to eq(180.16)
    end

    it 'gets distance of customer2 from origin' do
      expect(customer2_location).to receive(:distance_to).with(origin)
      expect(customer2.distance_to(origin)).to eq(10.57)
    end
  end
end