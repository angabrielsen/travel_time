require 'sniff'
require 'date'
require 'date_time'

class TravelTime

  # computes the average travel time (as a decimal number of seconds) from some point a (where start_sensors are located) to point b (where end_sensors are located)
  # for a given range of time (start_time to end_time) for example from 6 AM to 7 AM
  # you should use the last time a device was seen at the start beacons and the first time they were seen at the end beacons
  #
  # arguments: sniffs (an array of sniff objects)
  # start_time (exclude sniffs before this)
  # end_time (exclude sniffs after this)
  # start_sensors (an array of sensors which are located at the start)
  # end_sensors (an array of sensors which are located at the end)
  #
  # Note: You can get the fractional seconds from a DateTime using to_f (definition in date_time.rb)
  def self.average(sniffs, start_time, end_time, start_sensors, end_sensors)
    valid_time_sniffs = []
    valid_sensors = []

    sniffs.each do |sniff|
      if sniff.time >= start_time && sniff.time <= end_time
        valid_time_sniffs << sniff
      end
    end

    valid_time_sniffs.each do |valid_time_sniff|
      if valid_time_sniff.sensor_id == start_sensors || end_sensors
        valid_sensors << valid_time_sniff
      end
    end
  end
end