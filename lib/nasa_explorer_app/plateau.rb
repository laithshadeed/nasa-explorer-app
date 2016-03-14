require 'nasa_explorer_app/grid'

module NasaExplorerApp
  # Plateau class represents the logical area where the Rover will land
  # and explore. It will consists of many grids. The application will not
  # have access to those grids. It will interact with them via Plateau
  # using add/remove/get grid methods.
  # Internally, Plateau is implemented as Graph using adjaceny list. The
  # Grids are nodes. They are stored in a hash with the position: x,y as
  # key. Each grid knows about its neighbours via a list.
  class Plateau
    # This limit has been chosen arbitrary. Due to the fact I will create
    # grid obects of MAX_X x MAX_Y. I thought such limit should
    # be good enough due to memory constraints.
    MAX_X = 63
    MAX_Y = 63

    attr_reader :max_x, :max_y, :grids

    # It does hash-lookup using x,y to fetch the grid from @grids
    # If not found, it will create a new grid
    def get_or_create_grid!(args)
      x = Integer(args[:x])
      y = Integer(args[:y])
      k = "#{x},#{y}"

      # For simplicity, outside-range will be set to nil, instead of raising
      # and error
      return nil if x < 0 || x > @max_x
      return nil if y < 0 || y > @max_y

      return @grids[k] if @grids.key?(k)

      grid = @grids[k] = Grid.new(x: args[:x], y: args[:y], plateau: self)
      return grid
    end

    # It does breadth-first search (BFS) to traverse the graph of grids
    def print
      visited = {}
      grid = get_or_create_grid!(x: 0, y: 0)
      visited[grid.object_id] = 1
      queue = [grid]

      until queue.empty?
        g = queue.pop

        # Skip if nil
        next unless g

        # Print its coordinates
        puts "#{g.x},#{g.y},#{g.object_id}"

        g.neighbours.values.each do |n|
          # Skip it if nill or already visited
          next if !n || visited[n.object_id]

          # Add to the queue
          queue.unshift(n)

          # Mark as visited
          visited[n.object_id] = 1
        end
      end
    end

    def initialize(args)
      # Set instance variables
      @max_x = Integer args[:max_x]
      @max_y = Integer args[:max_y]
      @grids = {}

      _validate_args
      _create_graph!
    end

    private

    def _validate_args
      raise ArgumentError, 'input max_x is larger than MAX_X' if @max_x > MAX_X
      raise ArgumentError, 'input max_y is larger than MAX_Y' if @max_y > MAX_Y
    end

    # Create the graph by storing at as hash with the x,y as key
    def _create_graph!
      (0..@max_x).each do |x|
        (0..@max_y).each do |y|
          grid = get_or_create_grid!(x: x, y: y)
          grid.set_neighours!
        end
      end
    end
  end
end
