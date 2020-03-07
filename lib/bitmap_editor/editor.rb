# frozen_string_literal: true
require 'pry'

class BitmapEditor
  class Editor
    DEFAULT_COLOR = 'O'.freeze

    class << self
      def create_new_canvas(width, height)
        field = Array.new(width, DEFAULT_COLOR) { Array.new(width, DEFAULT_COLOR) }
        Canvas.new(field)
      end

      def clear_canvas(canvas)
        height = canvas.field.size
        width = canvas.field.first.size
        create_new_canvas(width, height)
      end

      def color_pixel(canvas, x, y, color)
        # canvas.field[x - 1][y - 1] = color
        # canvas
        new_field = canvas.field.map.with_index do |row, row_index|
          row.map.with_index do |column_value, column_index|
            if row_index + 1 == x && column_index + 1 == y
              color
            else
              column_value
            end
          end
        end
        Canvas.new(new_field)
      end

      def draw_vertical_segment(canvas, column_number, start_row, end_row, color)
        # for i in (start_row - 1)..(end_row - 1) do
        #   puts i
        #   canvas.field[i][column - 1] = color
        # end
        # canvas
        new_field = canvas.field.map.with_index do |row, row_index|
          row.map.with_index do |column_value, column_index|
            if row_index + 1 >= start_row && row_index + 1 <= end_row && column_index + 1 == column_number
              color
            else
              column_value
            end
          end
        end
        Canvas.new(new_field)
      end

      def draw_horizontal_segment(canvas, start_column, end_column, row_number, color)
        # for i in (start_column - 1)..(end_column - 1) do
        #   canvas.field[row - 1][i] = color
        # end
        # canvas

        new_field = canvas.field.map.with_index do |row, row_index|
          row.map.with_index do |column_value, column_index|
            if row_index + 1 == row_number && column_index + 1 >= start_column && column_index + 1 <= end_column
              color
            else
              column_value
            end
          end
        end
        Canvas.new(new_field)
      end
    end
  end
end
