# frozen_string_literal: true

require 'pry'

class Canvas
  def initialize(width, height, color)
    @field = Array.new(height) { Array.new(width, color) }
  end

  def height
    field.size
  end

  def width
    field.first.size
  end

  def rows
    field
  end

  def color_pixel(x, y, color)
    new_field = self.field.map.with_index do |row, row_index|
      row.map.with_index do |column_value, column_index|
        if row_index + 1 == y && column_index + 1 == x
          color
        else
          column_value
        end
      end
    end
    self.field = new_field
    self
  end

  def draw_vertical_segment(column, row_start, row_end, color)
    new_field = field.map.with_index do |row_columns, row_index|
      row_columns.map.with_index do |column_value, column_index|
        if row_index + 1 >= row_start && row_index + 1 <= row_end && column_index + 1 == column
          color
        else
          column_value
        end
      end
    end
    self.field = new_field
    self
  end

  def draw_horizontal_segment(row, column_start, column_end, color)
    new_field = field.map.with_index do |row_columns, row_index|
      row_columns.map.with_index do |column_value, column_index|
        if row_index + 1 == row && column_index + 1 >= column_start && column_index + 1 <= column_end
          color
        else
          column_value
        end
      end
    end
    self.field = new_field
    self
  end

  def to_s
    field.map { _1.join }.join("\n")
  end

  private

  attr_accessor :field
end
