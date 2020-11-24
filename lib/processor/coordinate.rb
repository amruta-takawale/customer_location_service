# frozen_string_literal: true

module Processor
  # Geo-coordinates
  class Coordinate
    include Error

    attr_accessor :latitude, :longitude

    def self.build(lat, lng)
      validate(lat, lng)
      Processor::Coordinate.new(lat, lng)
    end

    def initialize(lat, lng)
      @latitude = lat
      @longitude = lng
    end

    def self.validate(lat, lng)
      raise InvalidDataType, "Latitude/Longitude should be Numeric" unless lat.is_a?(Numeric) && lng.is_a?(Numeric)
      raise OutofRange, "Latitude out of range" unless (-90..90).include? lat
      raise OutofRange, "Longitude out of range" unless (-180..180).include? lng
    end
  end
end
