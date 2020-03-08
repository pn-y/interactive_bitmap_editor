# frozen_string_literal: true

require 'test_helper'

class PrinterTest < Minitest::Test
  def test_print_canvas
    canvas = BitmapEditor::Editor.create_new_canvas(width: 2, height: 2).value!
    result = BitmapEditor::Editor.color_pixel(canvas: canvas, x: 2, y: 2, color: 'Z')
    out, = capture_io do
      BitmapEditor::Printer.call(canvas)
    end

    assert { out == "OO\nOZ\n" }
  end
end
