# Start up of the Application
def welcome_to_parking
  puts 'Welcome to the parking area'
  puts "Do you want to park/unpark/find your vehicle or exit?
  Please reply with following:
  0 ---> for park \n
  1 ---> for unpark \n
  2 ---> for find \n
  3 ---> for exit"
  response = gets.chomp
  if response == '0'
    puts 'What type of vehicle is yours, i.e car or scooter?'
    type_of_vehicle = gets.chomp
    if type_of_vehicle.present?
        if type_of_vehicle == 'car'
          parkings_available = FourWheeler.where(status: 'vacant')
          if parkings_available.present?
            ParkingSlot.new.check_for_all_available_parking_slots(type_of_vehicle, parkings_available)
            ParkingSlot.new.check_for_slot(type_of_vehicle,parkings_available)
          else
            puts 'Sorry! No parking is available'
            welcome_to_parking
          end
        elsif type_of_vehicle == 'scooter'
          parkings_available = TwoWheeler.where(status: 'vacant')
          if parkings_available.present?
            ParkingSlot.new.check_for_all_available_parking_slots(type_of_vehicle,parkings_available)
            ParkingSlot.new.check_for_slot(type_of_vehicle,parkings_available)
          else
            puts 'Sorry! No parking is available'
            welcome_to_parking
          end
        else
          puts "We don't provide parking for #{type_of_vehicle} vehicle"
          welcome_to_parking
        end
    else
      puts 'Sorry! We have parking slots for only cars and scooters. Please provide proper type of vehicle.'
    end
  elsif response == '1'
    ParkingSlot.new.detail_to_unpark_slot('unpark')
  elsif response == '2'
    ParkingSlot.new.detail_to_unpark_slot('find')
  elsif response == '3'
    return
  else
    p 'Wrong input'
    welcome_to_parking
  end
end