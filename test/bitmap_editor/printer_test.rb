# frozen_string_literal: true

require 'test_helper'

class PrinterTest < Minitest::Test
  def test_print_canvas
    canvas = Canvas.new([%w[O Z], %w[Z O]])
    out, = capture_io do
      BitmapEditor::Printer.call(canvas)
    end

    assert { out == "OZ\nZO\n" }
  end
end
