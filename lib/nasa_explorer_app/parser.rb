module NasaExplorerApp
  # Parser class is simple one. It takes an input of filename
  # It parse it and populate max_{x,y} and rovers instance variables
  class Parser
    attr_reader :plateau_max_x, :plateau_max_y, :rovers

    def initialize(filename)
      @filename = filename
      @plateau_max_x = 0
      @plateau_max_y = 0
      @rovers = {}
    end

    def parse
      file = File.open(@filename)
      @plateau_max_x, @plateau_max_y = file.gets.chomp!.split(' ')
      until file.eof?
        rover_position = file.gets.chomp!.split(' ').join(',')
        rover_commands = file.gets.chomp!.split('')
        @rovers[rover_position] = rover_commands
      end
      file.close
    end
  end
end
