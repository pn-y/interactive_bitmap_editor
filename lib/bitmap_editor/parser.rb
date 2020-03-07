# frozen_string_literal: true
require 'dry/monads'
require 'pry'

class BitmapEditor
  class Parser
    COMMANDS = {
      'I' => { action: :create_canvas, args_count: 2 },
      'C' => { action: :clear_canvas, args_count: 0 },
      'L' => { action: :color_pixel, args_count: 3 },
      'V' => { action: :draw_vertical_segment, args_count: 4},
      'H' => { action: :draw_horizontal_segment, args_count: 4 },
      'S' => { action: :print_canvas, args_count: 0 },
    }
    class << self
      include Dry::Monads[:result]

      def call(string_command)
        literals = string_command.split(' ')
        action, *args = literals
        command = COMMANDS[action]
        return Failure("Doesn't know how to parse '#{string_command}'") if command.nil?
        return Failure("Wrong argument count in '#{string_command}'") if command[:args_count] != args.size
        Success({ action: command[:action], args: args })
      end
    end
  end
end
