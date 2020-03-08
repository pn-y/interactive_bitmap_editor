# frozen_string_literal: true

require 'test_helper'

class PrinterTest < Minitest::Test
  def test_print_canvas
    canvas = BitmapEditor::Editor.create_new_canvas(width: 2, height: 2).value!
    result = BitmapEditor::Editor.color_pixel(canvas: canvas, x_coord: 2, y_coord: 2, color: 'Z').value!
    out, = capture_io do
      BitmapEditor::Printer.call(result)
    end

    assert { out == "OO\nOZ\n" }
  end
end
