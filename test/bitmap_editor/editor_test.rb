# frozen_string_literal: true

require 'test_helper'

class EditorTest < Minitest::Test
  def test_create_new_canvas
    canvas = BitmapEditor::Editor.create_new_canvas(width: 2, height: 3).value!
    assert { canvas == Canvas.new([%w[O O], %w[O O], %w[O O]]) }
  end

  def test_clear_canvas
    canvas = BitmapEditor::Editor.create_new_canvas(width: 2, height: 2).value!
    canvas = BitmapEditor::Editor.color_pixel(canvas: canvas, x: 2, y: 2, color: 'Z').value!
    result = BitmapEditor::Editor.clear_canvas(canvas: canvas)
    assert { result.success == Canvas.new([%w[O O], %w[O O]]) }
  end

  def test_color_pixel
    canvas = BitmapEditor::Editor.create_new_canvas(width: 2, height: 2).value!
    result = BitmapEditor::Editor.color_pixel(canvas: canvas, x: 2, y: 2, color: 'Z')
    assert { result.success == Canvas.new([%w[O O], %w[O Z]]) }
  end

  def test_draw_vertical_segment
    canvas = BitmapEditor::Editor.create_new_canvas(width: 3, height: 3).value!
    result = BitmapEditor::Editor.draw_vertical_segment(canvas: canvas, column: 2, row_start: 1, row_end: 2, color: 'Z')
    assert { result.success == Canvas.new([%w[O Z O], %w[O Z O], %w[O O O]]) }
  end

  def test_draw_horizontal_segment
    canvas = BitmapEditor::Editor.create_new_canvas(width: 3, height: 3).value!
    result = BitmapEditor::Editor.draw_horizontal_segment(canvas: canvas, column_start: 1, column_end: 2, row: 3, color: 'Z')
    assert { result.success == Canvas.new([%w[O O O], %w[O O O], %w[Z Z O]]) }
  end
end
