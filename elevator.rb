require 'floor_request'

class Elevator

  attr_accessor :floor_requests, :current_floor

  def initialize
    @floor_requests = []
    @destinations   = []
    @current_floor  = -1
  end

  # when people press buttons inside the elevator
  # they are adding destinations
  def add_destinations(floors)
    filter(floors)
    @destinations << floors 
    @destinations.flatten!
    @destinations.sort!
    @destinations.reverse! if current_floor_request.down?
  end

  def filter(floors)
    floors.delete_if {|floor| floor <= @current_floor } if current_floor_request.direction == 'up' 
    floors.delete_if {|floor| floor >= @current_floor } if current_floor_request.direction == 'down' 
  end

  def final_destination
    @destinations.last
  end

  def current_floor_request
    @floor_requests.first 
  end

  # we will take people to their destinations 
  # and after we reach the final destination we
  # will complete the floor request by removing it 
  # from the elevators floor request queue
  def work(destinations)
    floor_request  = @floor_requests.delete_at(0)
    @current_floor = floor_requests.floor 

    add_destinations(destinations)

    until @destinations.empty? do 
      destination    = @destinations.delete_at(0)
      @current_floor = destination
      puts "visiting #{@current_floor}"
    end
  end

  def run
    while(true) do
      rand(1).zero? ? direction = 'up' : direction = 'down'
      self.floor_requests << FloorRequest.new({:floor => rand(10), :direction => direction})
      self.work((1..10).to_a.sort_by { rand }[0..4] )
    end
  end

end
