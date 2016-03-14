require 'nasa_explorer_app/facing'

module NasaExplorerApp
  # It represents the Rover. Basically it takes an input of:
  # facing (heading), initial position (x,y) and the Plateau object
  # It will know how dispatch the movment commands by delegating to
  # other objects:
  # 1. It delegates rotation commands to Facing object.
  #    The idea is Facing object (internaly circular linked-list) will
  #    know what is next direction for right or left.
  # 2. It delegates moving forward command to Grid object. The idea
  #    is Grid object is a node of Plateau (internally graph) and it
  #    knows about its neighours.
  #
  # From a Rover point of view. Its current position is simple a Grid object
  # and its facing is a Facing object. Its land is Plateau object
  class Rover
    def initialize(args)
      (x, y, facing_value) = args[:position].split(',')
      @plateau = args[:plateau]
      @grid = @plateau.get_or_create_grid!(x: x, y: y)

      @commands_map = {
        'L' => 'rotate_left',
        'R' => 'rotate_right',
        'M' => 'move_forward'
      }
      @facing = Facing.new(facing_value)
    end

    def dispatch_commands(commands)
      commands.each do |c|
        dispatch_command(c)
      end
    end

    def dispatch_command(command)
      action = @commands_map[command]
      method(action).call if action
    end

    def rotate_left
      @facing.rotate_left
    end

    def rotate_right
      @facing.rotate_right
    end

    def move_forward
      @grid = @grid.get_neighour(@facing.to_s)
      raise ArgumentError, 'Rover hit the border of the plateau' unless @grid
    end

    def print_position
      puts @grid.to_s + ' ' + @facing.to_s
    end
  end
end
