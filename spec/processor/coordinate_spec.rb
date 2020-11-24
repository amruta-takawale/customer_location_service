# frozen_string_literal: true

require "processor"
require "active_support/core_ext/hash"

RSpec.describe Processor::Coordinate do
  describe ".build" do
    subject { Processor::Coordinate }
    context "when passed valid params" do
      it "builds coordinate" do
        allow(subject).to receive(:validate).with(51.802, -9.442).and_return(true)
        coordinate = subject.build(51.802, -9.442)
        expect(coordinate.latitude).to be_eql(51.802)
        expect(coordinate.longitude).to be_eql(-9.442)
        expect(coordinate).to be_a(Processor::Coordinate)
      end
    end

    context "when passed invalid params" do
      it "raises error InvalidDataType" do
        expect { subject.build("string", -9.442) }.to raise_error(Processor::Error::InvalidDataType)
      end

      it "raises error InvalidDataType" do
        expect { subject.build(-9.442, { longitude: -9.442 }) }.to raise_error(Processor::Error::InvalidDataType)
      end

      it "raises error OutofRange - latitude" do
        expect { subject.build(91, -9.442) }.to raise_error(Processor::Error::OutofRange)
      end

      it "raises error OutofRange - longitude" do
        expect { subject.build(51.802, -190) }.to raise_error(Processor::Error::OutofRange)
      end
    end
  end

  describe '#distance_to' do
    let(:origin) { Processor::Coordinate.new(53.339428, -6.257664) }
    let(:customer2_location) { Processor::Coordinate.new(53.2451022, -6.238335)}

    it { expect(customer2_location.distance_to(origin)).to eql(10.57) }
    it { expect(origin.distance_to(customer2_location)).to eql(10.57) }
  end
end
