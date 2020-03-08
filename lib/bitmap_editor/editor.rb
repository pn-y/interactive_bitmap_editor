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
        field = Array.new(height) { Array.new(width, DEFAULT_COLOR) }
        Success(Canvas.new(field))
      end

      def clear_canvas(canvas:)
        height = canvas.field.size
        width = canvas.field.first.size
        create_new_canvas(width: width, height: height)
      end

      def color_pixel(canvas:, x:, y:, color:)
        # canvas.field[y - 1][x - 1] = color
        # Success(canvas)
        new_field = canvas.field.map.with_index do |row, row_index|
          row.map.with_index do |column_value, column_index|
            if row_index + 1 == y && column_index + 1 == x
              color
            else
              column_value
            end
          end
        end
        Success(Canvas.new(new_field))
      end

      def draw_vertical_segment(canvas:, column:, row_start:, row_end:, color:)
        # for i in (start_row - 1)..(end_row - 1) do
        #   puts i
        #   canvas.field[i][column - 1] = color
        # end
        # Success(canvas)
        new_field = canvas.field.map.with_index do |row_columns, row_index|
          row_columns.map.with_index do |column_value, column_index|
            if row_index + 1 >= row_start && row_index + 1 <= row_end && column_index + 1 == column
              color
            else
              column_value
            end
          end
        end
        Success(Canvas.new(new_field))
      end

      def draw_horizontal_segment(canvas:, column_start:, column_end:, row:, color:)
        # for i in (start_column - 1)..(end_column - 1) do
        #   canvas.field[row - 1][i] = color
        # end
        # Success(canvas)

        new_field = canvas.field.map.with_index do |row_columns, row_index|
          row_columns.map.with_index do |column_value, column_index|
            if row_index + 1 == row && column_index + 1 >= column_start && column_index + 1 <= column_end
              color
            else
              column_value
            end
          end
        end
        Success(Canvas.new(new_field))
      end

      def print_canvas(canvas:)
        Printer.call(canvas)
        Success(canvas)
      end
    end
  end
end
