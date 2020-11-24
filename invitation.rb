# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(".", "lib")

require "parser"
require "processor"

def invite(input_file, origin_lat, origin_lng, _distance)
  fetch_customers(input_file)
  origin_coord = Processor::Coordinate.build(origin_lat.to_f, origin_lng.to_f)
rescue StandardError => e
  p "#{e.class}- #{e.message}"
end

def fetch_customers(input_file)
  customer_factory = Processor::CustomerFactory.new
  Parser::CustomerStore.load_file(input_file, customer_factory)
end

invite("data/customers.txt", "53.339428", "-6.257664", 100)
