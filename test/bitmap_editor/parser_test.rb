# frozen_string_literal: true

require 'test_helper'

class ParserTest < Minitest::Test
  def test_print
    result = BitmapEditor::Parser.call('S')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :print_canvas }
  end

  def test_draw_horizontal_segment
    result = BitmapEditor::Parser.call('H 1 2 3 C')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :draw_horizontal_segment }
    assert { value[:color] == 'C' }
    assert { value[:row] == 3 }
    assert { value[:column_start] == 1 }
    assert { value[:column_end] == 2 }
  end

  def test_draw_vertical_segment
    result = BitmapEditor::Parser.call('V 3 1 2 C')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :draw_vertical_segment }
    assert { value[:color] == 'C' }
    assert { value[:column] == 3 }
    assert { value[:row_start] == 1 }
    assert { value[:row_end] == 2 }
  end

  def test_color_pixel
    result = BitmapEditor::Parser.call('L 2 1 C')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :color_pixel }
    assert { value[:x_coord] == 2 }
    assert { value[:y_coord] == 1 }
    assert { value[:color] == 'C' }
  end

  def test_clear_canvas
    result = BitmapEditor::Parser.call('C')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :clear_canvas }
  end

  def test_clear_canvas_with_more_args
    result = BitmapEditor::Parser.call('C 1')
    assert { result.failure? }
  end

  def test_create_new_canvas
    result = BitmapEditor::Parser.call('I 2 2')

    assert { result.success? }
    value = result.success
    assert { value[:action] == :create_canvas }
    assert { value[:width] == 2 }
    assert { value[:height] == 2 }
  end

  def test_create_new_canvas_with_invalid_args
    result = BitmapEditor::Parser.call('I 2 2e')

    assert { result.failure? }
  end
end
