# frozen_string_literal: true
require 'dry/monads'
require 'pry'

class BitmapEditor
  class Parser
    CREATE_CANVAS = 'I'.freeze
    CLEAR_CANVAS = 'C'.freeze
    PRINT_CANVAS = 'S'.freeze
    COLOR_PIXEL = 'L'.freeze
    DRAW_VERTICAL_SEGMENT = 'V'.freeze
    DRAW_HORIZONTAL_SEGMENT = 'H'.freeze
    COMMANDS = {
      CREATE_CANVAS => { action: :create_canvas, args_count: 2 },
      CLEAR_CANVAS => { action: :clear_canvas, args_count: 0 },
      COLOR_PIXEL => { action: :color_pixel, args_count: 3 },
      DRAW_VERTICAL_SEGMENT => { action: :draw_vertical_segment, args_count: 4},
      DRAW_HORIZONTAL_SEGMENT => { action: :draw_horizontal_segment, args_count: 4 },
      PRINT_CANVAS => { action: :print_canvas, args_count: 0 },
    }
    ALLOWED_COLORS = [*('A'..'Z')].freeze

    class << self
      include Dry::Monads[:result]

      def call(string_command)
        parse(string_command)
      end

      private

      def parse(string_command)
        values = string_command.split(' ')
        case values
        in [CLEAR_CANVAS]
          Success(action: COMMANDS[CLEAR_CANVAS][:action])
        in [PRINT_CANVAS]
          Success(action: COMMANDS[PRINT_CANVAS][:action])
        in [CREATE_CANVAS, width, height]
          cast_result = cast_to_int([width, height])
          return Failure("Doesn't know how to parse '#{string_command}'") if cast_result.failure?
          width, height = cast_result.success
          Success(action: COMMANDS[CREATE_CANVAS][:action], width: width, height: height)
          in [COLOR_PIXEL, x, y, String => color] if ALLOWED_COLORS.include?(color)
          cast_result = cast_to_int([x, y])
          return Failure("Doesn't know how to parse '#{string_command}'") if cast_result.failure?
          x, y = cast_result.success
          Success(action: COMMANDS[COLOR_PIXEL][:action], x: x, y: y, color: color)
        in [DRAW_HORIZONTAL_SEGMENT, column_start, column_end, row, String => color] if ALLOWED_COLORS.include?(color)
          cast_result = cast_to_int([column_start, column_end, row])
          return Failure("Doesn't know how to parse '#{string_command}'") if cast_result.failure?
          column_start, column_end, row = cast_result.success
          Success(action: COMMANDS[DRAW_HORIZONTAL_SEGMENT][:action], column_start: column_start, column_end: column_end, row: row, color: color)
        in [DRAW_VERTICAL_SEGMENT, column, row_start, row_end, String => color] if ALLOWED_COLORS.include?(color)
          cast_result = cast_to_int([column, row_start, row_end])
          return Failure("Doesn't know how to parse '#{string_command}'") if cast_result.failure?
          column, row_start, row_end = cast_result.success
          Success(action: COMMANDS[DRAW_VERTICAL_SEGMENT][:action], row_start: row_start, row_end: row_end, column: column, color: color)
        else
          Failure("Doesn't know how to parse '#{string_command}'")
        end
      end

      def cast_to_int(values)
        Success(values.map { |v| Integer(v) })
      rescue ArgumentError
        return Failure()
      end
    end
  end
end
