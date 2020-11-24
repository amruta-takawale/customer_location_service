# frozen_string_literal: true

require "processor"
require "active_support/core_ext/hash"

RSpec.describe Processor::CustomerFactory do
  subject { Processor::CustomerFactory.new }

  describe "#build" do
    context "when passed valid params" do
      it "builds customer" do
        allow(subject).to receive(:validate).with({ "latitude": "51.802", "user_id": 2, "name": "David Ahearn", "longitude": "-9.442" }.with_indifferent_access).and_return(true)
        customer = subject.build({ "latitude": "51.802", "user_id": 2, "name": "David Ahearn", "longitude": "-9.442" }.with_indifferent_access)
        expect(customer.name).to be_eql("David Ahearn")
        expect(customer.location).to be_a(Processor::Coordinate)
      end
    end

    context "when passed invalid params" do
      it "raises error UserNameNotPresent - when invalid name" do
        expect { subject.build({ "latitude": "51.802", "user_id": 2, "name": "", "longitude": "-9.442" }.with_indifferent_access) }.to raise_error(Processor::Error::UserNameNotPresent)
      end

      it "raises error UserIdNotPresent - when invalid id" do
        expect { subject.build({ "latitude": "51.802", "name": "David Ahearn", "longitude": "-9.442" }.with_indifferent_access) }.to raise_error(Processor::Error::UserIdNotPresent)
      end

      it "raises error UserlatNotPresent - when invalid latitude" do
        expect { subject.build({ "latitude": "", "user_id": 2, "name": "David Ahearn", "longitude": "-9.442" }.with_indifferent_access) }.to raise_error(Processor::Error::UserlatNotPresent)
      end

      it "raises error UserlngNotPresent - when invalid longitude" do
        expect { subject.build({ "latitude": "51.802", "user_id": 2, "name": "David Ahearn" }.with_indifferent_access) }.to raise_error(Processor::Error::UserlngNotPresent)
      end
    end
  end
end
