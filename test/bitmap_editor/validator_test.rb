# frozen_string_literal: true

require 'test_helper'

class ComandValidatorTest < Minitest::Test
  def test_create_canvas
    result = BitmapEditor::CommandValidator.call(action: :create_canvas, args: [2, 2])
    assert { result.success? }
  end

  def test_create_canvas_zero_width_height
    result = BitmapEditor::CommandValidator.call(action: :create_canvas, args: [0, 0])
    assert { result.failure? }
  end

  def test_create_canvas_big_height_width
    result = BitmapEditor::CommandValidator.call(action: :create_canvas, args: [251, 251])
    assert { result.failure? }
  end

  def test_print_canvas
    result = BitmapEditor::CommandValidator.call(action: :print_canvas, args: [])
    assert { result.success? }
  end

  def test_clear_canvas
    result = BitmapEditor::CommandValidator.call(action: :clear_canvas, args: [])
    assert { result.success? }
  end

  def test_color_pixel
    result = BitmapEditor::CommandValidator.call(action: :color_pixel, args: [2,2,'C'])
    assert { result.success? }
  end

  def test_draw_vertical_segment
    result = BitmapEditor::CommandValidator.call(action: :draw_vertical_segment, args: [2,2,2,'C'])
    assert { result.success? }
  end

  def test_draw_horizontal_segment
    result = BitmapEditor::CommandValidator.call(action: :draw_horizontal_segment, args: [2,2,2,'C'])
    assert { result.success? }
  end
end
