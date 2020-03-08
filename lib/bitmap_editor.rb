# frozen_string_literal: true

require 'dry/monads'
require_relative 'canvas'
require_relative 'bitmap_editor/editor.rb'
require_relative 'bitmap_editor/printer.rb'
require_relative 'bitmap_editor/parser.rb'

require 'pry'

class BitmapEditor
  include Dry::Monads[:result, :do]

  def process(path)
    canvas = Canvas.new

    content = File.read(path)
    commands = content.split("\n")
    parsed_commands = yield parse_commands(commands)
    execute_commands(parsed_commands)
  end

  private

  def parse_commands(commands)
    commands.map { |command| Parser.call(command) }
  end

  def execute_commands(parsed_commands)
    canvas = nil
    parsed_commands.fmap do |command|
      canvas = yield edit(canvas: canvas, **command)
    end
    Success(canvas)
  end

  def edit(args)
    Editor.call(**args)
  end
end
