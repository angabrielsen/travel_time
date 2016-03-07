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
    #keep sniffs in time frame
    in_time_sniffs = []

    sniffs.each do |sniff|
      if sniff.time >= start_time && sniff.time <= end_time
        in_time_sniffs << sniff
      end
    end

    #group sniffs by device id
    grouped = in_time_sniffs.group_by { |in_time_sniff| in_time_sniff.device_id }

    #create an array of pairs of sniffs that passed both sensors
    time_pairs = []

    grouped.each do |device_id, sniffs|
      #only manipulate data from collections with more than one sniff
      if sniffs.length > 1
        first_start = sniffs.select {|sniff| start_sensors.include?(sniff.sensor_id) }
        first_end = sniffs.select {|sniff| end_sensors.include?(sniff.sensor_id) }

        time_pairs << [(first_start.first).time.to_f, (first_end.first).time.to_f]
      elsif
        nil
      end
    end

    #calculate times from start_sensors to end_sensors
    trip_times = []

    time_pairs.each do |time_pair|
      if time_pair.first < time_pair.last
        trip_times << time_pair.last - time_pair.first
      end
    end

    #avg all trip times
    trip_times.each do |time|
      @avgs = trip_times.inject { |sum, pair| sum + pair } / trip_times.size
    end

    #display result
    if trip_times.size == 0
      nil
    else
      @avgs
    end
  end
end