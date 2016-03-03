require 'travel_time'
require 'sniff'
require 'date'

RSpec.describe TravelTime, "#average" do
  context "with 2 sniffs" do
    it "returns the travel time in decimal seconds" do
      sniffs = [Sniff.new(1, DateTime.new(2015, 7, 22, 2, 30), "00:00:00:00:00:00"), 
      Sniff.new(2, DateTime.new(2015, 7, 22, 2, 50), "00:00:00:00:00:00")]

      start_time = DateTime.new(2015, 7, 22, 2, 0)
    
      end_time = DateTime.new(2015, 7, 22, 3, 0)

      start_sensors = [1]

      end_sensors = [2]

      expect(TravelTime.average(sniffs, start_time, end_time, start_sensors, end_sensors)).to eq 20.0*60
    end
  end

  context "with 2 sniffs" do
    it "ignores backward travel time and returns nil" do
      sniffs = [Sniff.new(2, DateTime.new(2015, 7, 22, 2, 30), "00:00:00:00:00:00"), 
      Sniff.new(1, DateTime.new(2015, 7, 22, 2, 50), "00:00:00:00:00:00")]

      start_time = DateTime.new(2015, 7, 22, 2, 0)
    
      end_time = DateTime.new(2015, 7, 22, 3, 0)

      start_sensors = [1]

      end_sensors = [2]

      expect(TravelTime.average(sniffs, start_time, end_time, start_sensors, end_sensors)).to eq nil
    end
  end

  context "with 1 sniff" do
    it "returns nil" do
      sniffs = [Sniff.new(2, DateTime.new(2015, 7, 22, 2, 30), "00:00:00:00:00:00")]

      start_time = DateTime.new(2015, 7, 22, 2, 0)
    
      end_time = DateTime.new(2015, 7, 22, 3, 0)

      start_sensors = [1]

      end_sensors = [2]

      expect(TravelTime.average(sniffs, start_time, end_time, start_sensors, end_sensors)).to eq nil
    end
  end

  context "with 6 sniffs" do
    it "ignores sniffs out of the time ranges" do
      sniffs = [Sniff.new(1, DateTime.new(2015, 7, 22, 1, 50), "00:00:00:00:00:01"),
    Sniff.new(2, DateTime.new(2015, 7, 22, 1, 55), "00:00:00:00:00:01"),
    Sniff.new(1, DateTime.new(2015, 7, 22, 2, 10), "00:00:00:00:00:02"),
    Sniff.new(2, DateTime.new(2015, 7, 22, 2, 30), "00:00:00:00:00:02"),
    Sniff.new(1, DateTime.new(2015, 7, 22, 3, 10), "00:00:00:00:00:03"),
    Sniff.new(2, DateTime.new(2015, 7, 22, 3, 15), "00:00:00:00:00:03")]

      start_time = DateTime.new(2015, 7, 22, 2, 0)
    
      end_time = DateTime.new(2015, 7, 22, 3, 0)

      start_sensors = [1]

      end_sensors = [2]

      expect(TravelTime.average(sniffs, start_time, end_time, start_sensors, end_sensors)).to eq 20.0*60
    end
  end

  context "with 3 sniffs" do
    it "ignores sniffs from other beacons" do
      sniffs = [Sniff.new(1, DateTime.new(2015, 7, 22, 2, 10), "00:00:00:00:00:00"),
      Sniff.new(3, DateTime.new(2015, 7, 22, 2, 20), "00:00:00:00:00:00"),
      Sniff.new(2, DateTime.new(2015, 7, 22, 2, 30), "00:00:00:00:00:00")]

      start_time = DateTime.new(2015, 7, 22, 2, 0)
    
      end_time = DateTime.new(2015, 7, 22, 3, 0)

      start_sensors = [1]

      end_sensors = [2]

      expect(TravelTime.average(sniffs, start_time, end_time, start_sensors, end_sensors)).to eq 20.0*60
    end
  end

  context "with 4 sniffs" do
    it "correctly average travel time" do
      sniffs = [ Sniff.new(1, DateTime.new(2015, 7, 22, 1, 50), "00:00:00:00:00:01"),
          Sniff.new(2, DateTime.new(2015, 7, 22, 1, 55), "00:00:00:00:00:01"),
          Sniff.new(1, DateTime.new(2015, 7, 22, 2, 10), "00:00:00:00:00:02"),
          Sniff.new(2, DateTime.new(2015, 7, 22, 2, 30), "00:00:00:00:00:02")]

      start_time = DateTime.new(2015, 7, 22, 1, 0)
    
      end_time = DateTime.new(2015, 7, 22, 3, 0)

      start_sensors = [1]

      end_sensors = [2]

      expect(TravelTime.average(sniffs, start_time, end_time, start_sensors, end_sensors)).to eq (20+5.0)/2*60
    end
  end
end