class Point
  attr_accessor :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  def to_s
    "(#{x}, #{y})"
  end
end

class Rover
  attr_reader :facing, :position

  FACING_NORTH = 'north'.freeze
  FACING_EAST = 'east'.freeze
  FACING_SOUTH = 'south'.freeze
  FACING_WEST = 'west'.freeze

  def initialize
    @directions = [FACING_NORTH, FACING_EAST, FACING_SOUTH, FACING_WEST]
    @direction_index = 0
    @facing = FACING_NORTH
    @position = Point.new(x: 0, y: 0)
  end

  def turn_left
    @direction_index -= 1
    if @direction_index < 0
      @direction_index = @directions.length - 1
    end

    @facing = @directions[@direction_index]
  end

  def turn_right
    @direction_index += 1
    if @direction_index > @directions.length - 1
      @direction_index = 0
    end

    @facing = @directions[@direction_index]
  end

  def move_forward
    case @facing
    when FACING_NORTH
      @position.y = @position.y + 1
    when FACING_EAST
      @position.x = @position.x + 1
    when FACING_SOUTH
      @position.y = @position.y - 1
    when FACING_WEST
      @position.x = @position.x - 1
    else
      raise "Don't know how to handle that direction #{@facing}"
    end
  end

  def to_s
    "Robot at #{position} facing #{@facing}"
  end
end

class CommandLineInterface
  attr_accessor :rover

  def initialize
    @rover = Rover.new
  end

  def left
    rover.turn_left()
    puts rover
  end

  def right
    rover.turn_right()
    puts rover
  end

  def move_forward
    rover.move_forward()
    puts rover
  end

  def listen_command
    loop do
      puts "Command the robot with: "
      command = gets.chomp!
      case command
      when 'L'
        left()
      when 'R'
        right()
      when 'M'
        move_forward()
      when 'Q'
        puts "Robot shutting down."
        break
      else
        puts "Don't know how to handle this command: #{command}"
        next
      end
    end
  end
end

cli = CommandLineInterface.new()
cli.listen_command()
