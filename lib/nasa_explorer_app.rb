require 'nasa_explorer_app/version'
require 'nasa_explorer_app/rover'
require 'nasa_explorer_app/plateau'
require 'nasa_explorer_app/parser'

# This module is what you should call to interact with the application
# You will use to set the Plateau and the Rovers settings. Then it will compute
# the final position of the Rovers based on the instructions you provide
module NasaExplorerApp
  class << self
    def run(filename)
      parser = Parser.new(filename)
      parser.parse
      plateau = Plateau.new(max_x: parser.plateau_max_x,
                            max_y: parser.plateau_max_y)
      parser.rovers.each do |position, commands|
        rover = Rover.new(position: position, plateau: plateau)
        rover.dispatch_commands(commands)
        rover.print_position
      end
    end
  end
end
