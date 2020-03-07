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
  end

  def test_draw_vertical_segment
    result = BitmapEditor::Parser.call('V 3 1 2 C')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :draw_vertical_segment }
  end

  def test_color_pixel
    result = BitmapEditor::Parser.call('L 2 1 C')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :color_pixel }
  end

  def test_clear_canvas
    result = BitmapEditor::Parser.call('C')
    assert { result.success? }
    value = result.success
    assert { value[:action] == :clear_canvas }
  end

  def test_create_new_canvas
    result = BitmapEditor::Parser.call('I 2 2')

    assert { result.success? }
    value = result.success
    assert { value[:action] == :create_canvas }
  end
end
