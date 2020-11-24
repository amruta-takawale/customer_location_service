# frozen_string_literal: true

module Processor
  # Geo-coordinates
  class Coordinate
    include Error

    # radius of Earth in km
    RADIUS_OF_EARTH = 6371
    attr_accessor :latitude, :longitude

    def self.build(lat, lng)
      validate(lat, lng)
      Processor::Coordinate.new(lat, lng)
    end

    def initialize(lat, lng)
      @latitude = lat
      @longitude = lng
    end

    # Input distance in Degrees
    # Calculate distance in kilometer
    def distance_to(origin)
      rad_lat = to_rad(latitude)
      rad_lng = to_rad(longitude)

      rad_origin_lat = to_rad(origin.latitude)
      rad_origin_lng = to_rad(origin.longitude)

      # calculate λ- longitudinal delta
      delta_lng = rad_lng - rad_origin_lng
      # calculate φ- latitudinal delta
      delta_lat = rad_lat - rad_origin_lat

      # calculate central angle - σ
      central_angle = 2 * Math.asin(Math.sqrt((Math.sin(delta_lat / 2)**2) +
                      (Math.cos(rad_lat) * Math.cos(rad_origin_lat) * Math.sin(delta_lng / 2)**2)))
      (central_angle * RADIUS_OF_EARTH).round(2)
    end

    def self.validate(lat, lng)
      raise InvalidDataType, "Latitude/Longitude should be Numeric" unless lat.is_a?(Numeric) && lng.is_a?(Numeric)
      raise OutofRange, "Latitude out of range" unless (-90..90).include? lat
      raise OutofRange, "Longitude out of range" unless (-180..180).include? lng
    end

    def to_rad(value)
      value * Math::PI / 180
    end
  end
end
