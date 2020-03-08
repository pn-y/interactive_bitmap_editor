# frozen_string_literal: true

require 'pry'
require 'dry/monads'

class BitmapEditor
  class Editor
    DEFAULT_COLOR = 'O'

    class << self
      include Dry::Monads[:result]

      def call(action:, **args)
        case action
        in :create_canvas
          create_new_canvas(**args)
        in :clear_canvas
          clear_canvas(**args)
        in :color_pixel
          color_pixel(**args)
        in :draw_vertical_segment
          draw_vertical_segment(**args)
        in :draw_horizontal_segment
          draw_horizontal_segment(**args)
        in :print_canvas
          print_canvas(**args)
        end
      end

      def create_new_canvas(canvas: nil, width:, height:)
        Success(Canvas.new(width, height, DEFAULT_COLOR))
      end

      def clear_canvas(canvas:)
        height = canvas.height
        width = canvas.width
        create_new_canvas(width: width, height: height)
      end

      def color_pixel(canvas:, x:, y:, color:)
        Success(canvas.color_pixel(x, y, color))
      end

      def draw_vertical_segment(canvas:, column:, row_start:, row_end:, color:)
        Success(canvas.draw_vertical_segment(column, row_start, row_end, color))
      end

      def draw_horizontal_segment(canvas:, column_start:, column_end:, row:, color:)
        Success(canvas.draw_horizontal_segment(row, column_start, column_end, color))
      end

      def print_canvas(canvas:)
        Printer.call(canvas)
        Success(canvas)
      end
    end
  end
end
