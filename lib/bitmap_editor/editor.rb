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

      def color_pixel(canvas:, x_coord:, y_coord:, color:)
        return Failure('Canvas was not created') unless canvas

        if x_coord > canvas.width || y_coord > canvas.height
          return Failure("Cannot color point [#{x_coord},#{y_coord}] on canvas #{canvas.width}x#{canvas.height}")
        end

        Success(canvas.color_pixel(x_coord, y_coord, color))
      end

      def draw_vertical_segment(canvas:, column:, row_start:, row_end:, color:)
        return Failure('Canvas was not created') unless canvas
        if column > canvas.width || row_start > canvas.height || row_end > canvas.height
          return Failure("Cannot draw vertical segment in column #{column} from row #{row_start} to #{row_end} on canvas #{canvas.width}x#{canvas.height}")
        end

        Success(canvas.draw_vertical_segment(column, row_start, row_end, color))
      end

      def draw_horizontal_segment(canvas:, column_start:, column_end:, row:, color:)
        return Failure('Canvas was not created') unless canvas
        if row > canvas.height || column_start > canvas.width || column_end > canvas.width
          return Failure("Cannot draw horizontal segment in row #{row} from column #{column_start} to #{column_end} on canvas #{canvas.width}x#{canvas.height}")
        end

        Success(canvas.draw_horizontal_segment(row, column_start, column_end, color))
      end

      def print_canvas(canvas:)
        return Failure('Canvas was not created') unless canvas
        Printer.call(canvas)
        Success(canvas)
      end
    end
  end
end
