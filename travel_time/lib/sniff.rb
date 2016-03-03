# Represents one data point picked up by a sensor, we have the sensor_id, the time the device was seen, and the device (phone, tablet, etc) id
Sniff = Struct.new(:sensor_id, :time, :device_id)