module NasaExplorerApp
  # Circular linked-list presenation for the rover facing
  # It do know how to rotate right or left
  class Facing
    # Model the Node of the linked-list as Struct
    Direction = Struct.new :value, :prev, :next

    def initialize(direction)
      # I will assume we have the four directions in this way
      #   N
      # W   E
      #   S
      # flattening it into a circular doubly-linked list will look like
      #  .. E <-> N <-> W <-> S <-> E <-> N <->..
      # I will assume moving forward (next) will be rotate_left
      # moving backward (prev) will be rotate_right
      list = %w(N W S E)

      raise ArgumentError, 'Invalid facing direction' \
        unless list.include? direction

      _build_linked_list(list)

      # Reset @current to point to the current direction
      @current = @current.next while @current.value != direction
    end

    def rotate_left
      @current = @current.next
      self
    end

    def rotate_right
      @current = @current.prev
      self
    end

    def to_s
      @current.value
    end

    private

    def _build_linked_list(list)
      # Initialize everything to the first item in the list
      @current = head = prev = Direction.new(list.shift, nil, nil)

      # Create a doubly-linked list for directions
      list.each do |val|
        @current = Direction.new(val, prev, nil)
        prev.next = @current
        prev = @current
      end

      # Make the doubly-linked list circular
      @current.next = head
      head.prev = @current

      # Make current point to the head again
      @current = head
    end
  end
end
