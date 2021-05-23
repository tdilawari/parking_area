# Set up class Parking Slot
class ParkingSlot < ApplicationRecord
  belongs_to :vehicle

  def park(model, detail, type_of_vehicle, vacant_slot)
    parking_slot_id = ParkingSlot.find_by(id: vacant_slot.id)
    if parking_slot_id.present?
      p "Please park your #{type_of_vehicle}"
      vehicle = Vehicle.create(model: model.upcase, details: detail.upcase, type_of_vehicle: parking_slot_id.type)
    end
    parking_slot_id.update(vehicle_id: vehicle.id, status: 'filled')
    welcome_to_parking
  end

  def unpark(vehicle_parked_already)
    slot_parked = ParkingSlot.where(vehicle_id: vehicle_parked_already.id)
    slot_parked.update(vehicle_id: nil, status: 'vacant')
    vehicle_parked_already.destroy!
    puts "Your vehicle has been unparked successfully!"
    welcome_to_parking
  end

  def detail_to_park_slot(type_of_vehicle, parkings_available, slot)
    puts "Please give your #{type_of_vehicle} model and number"
    p 'Model:'
    model = gets.chomp
    p "#{type_of_vehicle} number:"
    details = gets.chomp
    ParkingSlot.new.park(model, details, type_of_vehicle, parkings_available.find_by(slot: slot))
  end

  def detail_to_unpark_slot(action)
    puts "Provide your vehicle details to #{action}"
    p 'Model:'
    model = gets.chomp
    p 'Vehicle Number:'
    details = gets.chomp
    vehicle_parked_already = Vehicle.find_by(details: details.upcase, model: model.upcase)
    if vehicle_parked_already.present?
      if action == 'unpark'
        ParkingSlot.new.unpark(vehicle_parked_already)
      elsif action == 'find'
        p "Vehicle found, it is parked at #{vehicle_parked_already.parking_slot.slot}"
        welcome_to_parking
      end
    else
      p 'No result found'
      welcome_to_parking
    end
  end

  def check_for_slot(type_of_vehicle, parkings_available)
      puts "Please reply with the slot number where you want to park"
      slot = gets.chomp
      if parkings_available.pluck(:slot).include? slot
        detail_to_park_slot(type_of_vehicle,parkings_available,slot)
      else
        puts 'You have entered wrong slot ID'
        check_for_slot(type_of_vehicle, parkings_available)
      end
  end

  def check_for_all_available_parking_slots(type_of_vehicle, parkings_available)
    puts "Check all available parking slots for #{type_of_vehicle}"
    parkings_available.each do |p|
      puts "Parking Slots--->
      #{p.slot} \n"
    end
  end
end