# frozen_string_literal: true
require 'dry/monads'

class BitmapEditor
  class CommandValidator
    MIN_SIZE = 1
    MAX_SIZE = 250
    ALLOWED_COLORS = [*('A'..'Z')].freeze

    class << self
      include Dry::Monads[:result]

      def call(action:, args:)
        case action
        in :print_canvas
          Success({ action: action })
        in :clear_canvas
          Success({ action: action })
        in :create_canvas
          width, height = args
          return Failure("cannot create canvas #{width} x #{height}") if args.any? { |arg| arg > MAX_SIZE || arg < MIN_SIZE }
          Success({ action: action, width: width, height: height })
        in :color_pixel
          x, y, color = args
          return Failure("color #{color} is not allowed") unless ALLOWED_COLORS.include?(color)
          return Failure("cannot color point [#{width}, #{height}]") if [x, y].any? { |arg| arg > MAX_SIZE || arg < MIN_SIZE }
          Success({ action: action, x: x, y: y, color: color })
        in :draw_vertical_segment
          column, start_row, end_row, color = args
          return Failure("cannot draw line at #{column} column") if column > MAX_SIZE || column < MIN_SIZE
          return Failure("cannot draw line starting in #{start_row} row") if start_row > MAX_SIZE || start_row < MIN_SIZE
          return Failure("cannot draw line ending in #{end_row} row") if end_row > MAX_SIZE || end_row < MIN_SIZE
          Success({ action: action, column: column, start_row: start_row, end_row: :end_row, color: color })
        in :draw_horizontal_segment
          start_column, end_column, row, color = args
          return Failure("cannot draw line at #{row} row") if row > MAX_SIZE || row < MIN_SIZE
          return Failure("cannot draw line starting in #{start_column} column") if start_column > MAX_SIZE || start_column < MIN_SIZE
          return Failure("cannot draw line ending in #{end_column} column") if end_column > MAX_SIZE || end_column < MIN_SIZE
          Success({ action: action, row: row, start_column: start_column, end_column: :end_column, color: color })
        end
      end
    end
  end
end
