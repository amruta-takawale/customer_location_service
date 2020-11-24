# frozen_string_literal: true

# process or transform data in required format
module Processor
  autoload :Customer, "processor/customer"
  autoload :CustomerFactory, "processor/customer_factory"
  autoload :Coordinate, "processor/coordinate"
  autoload :Error, "processor/error"
end
