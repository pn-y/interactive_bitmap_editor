# frozen_string_literal: true

require 'test_helper'

class BitmapEditorTest < Minitest::Test
  def test_process
    example_path = Dir.pwd + '/test/fixtures/example.txt'
    example_result = File.read(Dir.pwd + '/test/fixtures/example_result.txt')
    result = BitmapEditor.new.process(example_path)
    assert { result.to_s == example_result }
  end

  def test_process_with_clear
    example_path = Dir.pwd + '/test/fixtures/example_with_clear.txt'
    example_result = File.read(Dir.pwd + '/test/fixtures/example_with_clear_result.txt')
    result = BitmapEditor.new.process(example_path)
    assert { result.to_s == example_result }
  end

  def test_process_with_error
    example_path = Dir.pwd + '/test/fixtures/example_with_error.txt'
    result = BitmapEditor.new.process(example_path)
    assert { result.failure? }
  end
end
