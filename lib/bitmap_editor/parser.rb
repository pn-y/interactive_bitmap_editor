# frozen_string_literal: true

require 'dry/monads'
require 'pry'

class BitmapEditor
  class Parser
    CREATE_CANVAS = 'I'
    CLEAR_CANVAS = 'C'
    PRINT_CANVAS = 'S'
    COLOR_PIXEL = 'L'
    DRAW_VERTICAL_SEGMENT = 'V'
    DRAW_HORIZONTAL_SEGMENT = 'H'
    COMMANDS = {
      CREATE_CANVAS => { action: :create_canvas, args_count: 2 },
      CLEAR_CANVAS => { action: :clear_canvas, args_count: 0 },
      COLOR_PIXEL => { action: :color_pixel, args_count: 3 },
      DRAW_VERTICAL_SEGMENT => { action: :draw_vertical_segment, args_count: 4 },
      DRAW_HORIZONTAL_SEGMENT => { action: :draw_horizontal_segment, args_count: 4 },
      PRINT_CANVAS => { action: :print_canvas, args_count: 0 }
    }.freeze
    ALLOWED_COLORS = [*('A'..'Z')].freeze
    ALLOWED_SIZE_RANGE = (1..250).freeze

    class << self
      include Dry::Monads[:validated, :result]

      def call(string_command)
        parse(string_command)
      end

      private

      def parse(string_command)
        values = string_command.split(' ')
        case values
        in [CLEAR_CANVAS]
          Valid(action: COMMANDS[CLEAR_CANVAS][:action])
        in [PRINT_CANVAS]
          Valid(action: COMMANDS[PRINT_CANVAS][:action])
        in [CREATE_CANVAS, width, height]
          cast_result = cast_to_int([width, height])
          if cast_result.failure?
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          width, height = cast_result.success
          unless ALLOWED_SIZE_RANGE.include?(width) && ALLOWED_SIZE_RANGE.include?(height)
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          Valid(action: COMMANDS[CREATE_CANVAS][:action], width: width, height: height)
        in [COLOR_PIXEL, x_coord, y_coord, String => color] if ALLOWED_COLORS.include?(color)
          cast_result = cast_to_int([x_coord, y_coord])
          if cast_result.failure?
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          x_coord, y_coord = cast_result.success
          if !(ALLOWED_SIZE_RANGE.include?(x_coord) && ALLOWED_SIZE_RANGE.include?(y_coord))
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          Valid(action: COMMANDS[COLOR_PIXEL][:action], x_coord: x_coord, y_coord: y_coord, color: color)
        in [DRAW_HORIZONTAL_SEGMENT, column_start, column_end, row, String => color] if ALLOWED_COLORS.include?(color) && column_start <= column_end
          cast_result = cast_to_int([column_start, column_end, row])
          if cast_result.failure?
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          column_start, column_end, row = cast_result.success
          if !(ALLOWED_SIZE_RANGE.include?(row) && ALLOWED_SIZE_RANGE.include?(column_end) && ALLOWED_SIZE_RANGE.include?(column_start))
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          Valid(
            action: COMMANDS[DRAW_HORIZONTAL_SEGMENT][:action],
            column_start: column_start,
            column_end: column_end,
            row: row,
            color: color
          )
        in [DRAW_VERTICAL_SEGMENT, column, row_start, row_end, String => color] if ALLOWED_COLORS.include?(color) && row_start <= row_end
          cast_result = cast_to_int([column, row_start, row_end])
          if cast_result.failure?
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          column, row_start, row_end = cast_result.success
          if !(ALLOWED_SIZE_RANGE.include?(column) && ALLOWED_SIZE_RANGE.include?(row_end) && ALLOWED_SIZE_RANGE.include?(row_start))
            return Invalid("Doesn't know how to parse '#{string_command}'")
          end

          Valid(
            action: COMMANDS[DRAW_VERTICAL_SEGMENT][:action],
            row_start: row_start,
            row_end: row_end,
            column: column,
            color: color
          )
        else
          Invalid("Doesn't know how to parse line '#{string_command}'")
        end
      end

      def cast_to_int(values)
        Success(values.map { |v| Integer(v) })
      rescue ArgumentError
        Failure()
      end
    end
  end
end
