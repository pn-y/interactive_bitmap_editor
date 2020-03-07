require "minitest/autorun"
require 'test_helper'

class BitmapEditorTest < Minitest::Test
  def test_process
    example_path = Dir.pwd + '/test/fixtures/example.txt'
    example_result = File.read(Dir.pwd + '/test/fixtures/example_result.txt')
    result = BitmapEditor.process(example_path)
    assert { result ==  example_result }
  end
end
