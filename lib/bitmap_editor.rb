require_relative 'canvas'
require_relative 'bitmap_editor/editor.rb'
require_relative 'bitmap_editor/printer.rb'
require_relative 'bitmap_editor/validator.rb'

require 'pry'

class BitmapEditor
  class << self
    def process(path)
      canvas = Canvas.new

      content = File.read(path)
    end
  end
end
