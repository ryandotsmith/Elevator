require 'floor_request'

class Elevator

  attr_accessor :floor_requests

  def initialize
    @floor_requests = []
    @destinations   = []
  end

  def add_destinations(floors)
    @destinations << floors 
    @destinations.flatten!
    @destinations.sort!
    @destinations.reverse! if current_floor_request.down?
  end

  def final_destination
    @destinations.last
  end

  def current_floor_request
    @floor_requests.first 
  end

  def work(destinations)
    add_destinations(destinations)
    until @destinations.empty? do 
      destination = @destinations.delete_at(0)
      puts "visiting #{destination}"
    end
    @floor_requests.delete_at(0)
  end

  def run
    while(true) do
      rand(1).zero? ? direction = 'up' : direction = 'down'
      self.floor_requests << FloorRequest.new({:floor => rand(10), :direstion => direction})
      self.work((1..10).to_a.sort_by { rand }[0..4] )
    end
  end

end
