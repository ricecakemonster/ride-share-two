require 'csv'
require 'pry'

#Create Rideshare module
module Rideshare
#Create Trip class
  class Trip
    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

# trip_id,driver_id,rider_id,date,rating should be initialized
    def initialize(args)
      @trip_id = args[:trip_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]

      # each rating should be within an acceptable range (1-5)
      raise ArgumentError.new("Not a valid id") if @trip_id.class != Integer
      raise ArgumentError.new("Not a valid rating") if @rating > 5 || @rating < 0
    end

    #self.method1 : retrieve all trips from the CSV file
    def self.all
      trips = []
      CSV.read('./support/trips.csv').drop(1).each do |trip|
        trips << {trip_id: trip[0].to_i , driver_id: trip[1].to_i, rider_id: trip[2].to_i, date: trip[3], rating: trip[4].to_i}
      end
      return trips
    end

    #self.method2 : find all trip instances for a given driver ID
    def self.find_trip_by_driver(driver_id)
      raise ArgumentError.new("Not a valid ID number") if driver_id.class != Integer
      trips = all.select {|trip| trip[:driver_id] == driver_id}
      trips.any? ? trips : "No history of trips"
    end

    #self.method3 : find all trip instances for a given rider ID
    def self.find_trip_by_rider(rider_id)
      raise ArgumentError.new("Not a valid ID number") if rider_id.class != Integer
      trips = all.select {|trip| trip[:rider_id] == rider_id}
      trips.any? ? trips : "No history of trips"
    end

#instance_method1 : retrieve the associated driver instance through the driver ID
    def driver_info
      return Rideshare::Driver.find(@driver_id)
    end
#instance_method2 : retrieve the associated rider instance through the rider ID
    def rider_info
      return Rideshare::Rider.find(@rider_id)
    end
  end
end
