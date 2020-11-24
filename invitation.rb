# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(".", "lib")

require "parser"
require "processor"
require "pathname"

def invite(input_file, origin_lat, origin_lng, distance)
  customer_store = fetch_customers(input_file)
  origin_coord = Processor::Coordinate.build(origin_lat.to_f, origin_lng.to_f)
  nearby_customers(customer_store, origin_coord, distance)
  rescue StandardError => e
    p "#{e.class}- #{e.message}"
end

def fetch_customers(input_file)
  customer_factory = Processor::CustomerFactory.new
  Parser::CustomerStore.load_file(input_file, customer_factory)
end

def nearby_customers(customer_store, origin_coord, distance)
  file = create_file("tmp/output.txt")
  customer_store.nearby(origin_coord, distance).each do |customer|
    file.puts "#{customer.name} - #{customer.id}"
  end
  file.close
end

def create_file(path)
  Pathname(path).dirname.mkdir unless File.exist?(File.dirname(path))
  File.open(path, "w")
end

# params [input txt file, office_latitute, office_longitude, max_distance]
invite("data/customers.txt", "53.339428", "-6.257664", 100)
