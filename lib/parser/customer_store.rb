# frozen_string_literal: true

require "active_support/core_ext/hash"

module Parser
  # Builds Customer Store
  class CustomerStore
    include Processor::Error

    attr_accessor :customers

    def self.load_file(file_path, customer_factory)
      customers = []
      File.foreach(file_path) do |line|
        customers << customer_factory.build(eval(line).with_indifferent_access)
      end
      CustomerStore.new(customers)
    end

    def initialize(customers)
      @customers = customers
    end
  end
end
