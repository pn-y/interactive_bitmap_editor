require "minitest/autorun"

class PrinterTest < Minitest::Test
  def test_print_canvas
    canvas = Canvas.new([['O', 'Z'], ['Z', 'O']])
    out, _ = capture_io do
      BitmapEditor::Printer.call(canvas)
    end

    assert { out == "OZ\nZO\n" }
  end
end
