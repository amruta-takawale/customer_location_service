# frozen_string_literal: true

module Processor
  # Customer
  class Customer
    attr_accessor :id, :name, :location

    def initialize(user_id, name, location)
      @id = user_id
      @name = name
      @location = location
    end
  end
end
