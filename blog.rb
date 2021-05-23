# Instead of loading all of Rails, load the
# particular Rails dependencies we need
require 'pg'
require 'active_record'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'postgres',
  password: 'tanisha@123'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table "parking_slot", force: :cascade do |t|
    t.text     "slot"
    t.text   "status"
    t.integer  "vehicle_id"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
  create_table "vehicles", force: :cascade do |t|
    t.string   "type_of_vehicle"
    t.text "details"
    t.string "model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end

# Set up model classes
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

load 'vehicle.rb'

load 'parking_slot.rb'

load 'types_of_vehicle.rb'

# Clear up the history of records before executing fresh
ParkingSlot.destroy_all
TwoWheeler.destroy_all
FourWheeler.destroy_all
Vehicle.destroy_all

# Adding dummy data to the Parking Slot
TwoWheeler.create(slot: "A-01",status: "vacant")
FourWheeler.create(slot: "A-02",status: "vacant")
TwoWheeler.create(slot: "A-03",status: "vacant")
FourWheeler.create(slot: "A-04",status: "vacant")
FourWheeler.create(slot: "A-05",status: "vacant")
FourWheeler.create(slot: "A-06",status: "vacant")

load 'welcome_to_parking_area.rb'
welcome_to_parking