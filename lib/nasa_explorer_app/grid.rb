module NasaExplorerApp
  # Grid class represents the logical grid that we use to represent the
  # different pieces of the plateau. This class should *not* be used
  # directly from the outside world. It is internally used inside Plateau
  # think about as: Plateau consists of many grids. Note that it only has
  # x and y coordinates. For the orientation or facing, it will be property
  # for the rover itself.
  class Grid
    attr_reader :x, :y, :plateau, :neighbours

    # Example:
    #   grid = Grid.new({x: 3, y: 2, plateau: Plateau.new})
    #
    # This method will raise ArgumentError if
    # 1. x,y are not parsable integers (by Integer() function)
    # 2. If plateau key is not an Plateau instance
    def initialize(args)
      @x = Integer(args[:x])
      @y = Integer(args[:y])
      @plateau = args[:plateau]
      raise ArgumentError, 'not a plateau object' unless @plateau.is_a? Plateau
    end

    def set_neighours!
      @neighbours = {
        'E' => @plateau.get_or_create_grid!(x: @x + 1, y:     @y),
        'W' => @plateau.get_or_create_grid!(x: @x - 1, y:     @y),
        'N' => @plateau.get_or_create_grid!(x:     @x, y: @y + 1),
        'S' => @plateau.get_or_create_grid!(x:     @x, y: @y - 1)
      }
    end

    def get_neighour(direction)
      @neighbours[direction]
    end

    def to_s
      "#{@x} #{@y}"
    end
  end
end
