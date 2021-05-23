# Set up class vehicle
class Vehicle < ApplicationRecord
  has_one :parking_slot
  belongs_to :two_wheeler
  belongs_to :four_wheeler
end