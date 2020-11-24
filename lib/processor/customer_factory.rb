# frozen_string_literal: true

module Processor
  # Builds Customer attributes
  class CustomerFactory
    include Error

    def build(data)
      # raise error if user_id and name is not present
      validate(data)
      location = Coordinate.build(data[:latitude].to_f, data[:longitude].to_f)
      Customer.new(data[:user_id], data[:name], location)
    end

    private

    def validate(data)
      raise UserIdNotPresent if data[:user_id].blank?
      raise UserNameNotPresent, "User#{data[:user_id]}- Name is not present" if data[:name].blank?
      raise UserlatNotPresent, "User#{data[:user_id]}- Latitude is not present" if data[:latitude].blank?
      raise UserlngNotPresent, "User#{data[:user_id]}- Longitude is not present" if data[:longitude].blank?
    end
  end
end
