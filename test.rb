load 'floor_request.rb'
load 'elevator.rb'

Shindo.tests do
  test("the final destination should be the lowest floor in the requests if the elevator is going down") do
    @elevator = Elevator.new
    @elevator.floor_requests << FloorRequest.new(:floor => 10,:direction => 'down')
    @elevator.current_floor = 10
    @elevator.add_destinations([4,2,9])
    @elevator.final_destination == 2
  end

  test("the final destination should be the highest floor in the requests if the elevator is going up") do
    @elevator = Elevator.new
    @elevator.floor_requests << FloorRequest.new(:floor => 10,:direction => 'up')
    @elevator.add_destinations([4,2,9])
    @elevator.final_destination == 9
  end
end

Shindo.tests do
  test("removing floors requested that are below the current floor when the elevator is moving up") do
    @elevator = Elevator.new 
    @elevator.floor_requests << FloorRequest.new(:floor => 5,:direction => 'up')
    @elevator.current_floor = 5
    @floors = (1..10).to_a
    @elevator.filter(@floors) 
    @floors == [6,7,8,9,10]
  end
end
