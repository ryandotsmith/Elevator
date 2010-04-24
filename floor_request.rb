class FloorRequest
  attr_reader :direction, :floor
  def initialize(opts)
    @direction = opts[:direction]
    @floor     = opts[:floor]
  end

  def down?
    self.direction == 'down'
  end

  def up?
    self.direction == 'up'
  end
end
