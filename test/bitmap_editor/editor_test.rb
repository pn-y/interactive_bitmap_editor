# frozen_string_literal: true

require 'test_helper'

class EditorTest < Minitest::Test
  def test_create_new_canvas
    canvas = BitmapEditor::Editor.create_new_canvas(2, 2)
    assert { canvas == Canvas.new([%w[O O], %w[O O]]) }
  end

  def test_clear_canvas
    canvas = Canvas.new([%w[Z Z], %w[Z Z]])
    new_canvas = BitmapEditor::Editor.clear_canvas(canvas)
    assert { new_canvas == Canvas.new([%w[O O], %w[O O]]) }
  end

  def test_color_pixel
    canvas = BitmapEditor::Editor.create_new_canvas(2, 2)
    new_canvas = BitmapEditor::Editor.color_pixel(2, 2, 'Z')
    assert { new_canvas == Canvas.new([%w[O O], %w[O Z]]) }
  end

  def test_draw_vertical_segment
    canvas = BitmapEditor::Editor.create_new_canvas(3, 3)
    new_canvas = BitmapEditor::Editor.test_draw_vertical_segment(2, 1, 2, 'Z')
    assert { new_canvas == Canvas.new([%w[O Z O], %w[O Z O], %w[O O O]]) }
  end

  def test_draw_horizontal_segment
    canvas = BitmapEditor::Editor.create_new_canvas(3, 3)
    new_canvas = BitmapEditor::Editor.test_draw_horizontal_segment(2, 1, 2, 'Z')
    assert { new_canvas == Canvas.new([%w[O O O], %w[Z Z O], %w[O O O]]) }
  end
end
