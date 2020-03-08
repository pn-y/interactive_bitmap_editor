# frozen_string_literal: true

class Canvas
  attr_accessor :field

  def initialize(field = [])
    @field = field
  end

  def ==(another_canvas)
    field == another_canvas.field
  end

  def to_s
    field.map { |row| row.join }.join("\n")
  end
end
