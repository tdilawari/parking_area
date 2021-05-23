# Single table inheritance for types of vehicles
class TwoWheeler < ParkingSlot
  has_many :parking_slots
end

class FourWheeler < ParkingSlot
  has_many :parking_slots
end
