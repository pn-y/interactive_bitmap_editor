# frozen_string_literal: true

require 'dry/monads'
require_relative 'canvas'
require_relative 'bitmap_editor/editor.rb'
require_relative 'bitmap_editor/printer.rb'
require_relative 'bitmap_editor/parser.rb'

require 'pry'

class BitmapEditor
  include Dry::Monads[:result, :do, :list]

  def run(path)
    result = process(path)
    if result.success?
      puts 'Done'
    else
      puts result.failure
    end
  end

  def process(path)
    content = File.read(path)
    commands = content.split("\n")

    return Success() if commands.empty?

    parsed_commands = yield parse_commands(commands).traverse.to_result
    canvas = yield execute_commands(parsed_commands)
    Success(canvas)
  end

  private

  def parse_commands(commands)
    result = commands.map { |command| Parser.call(command) }
    List::Validated[*result]
  end

  def execute_commands(parsed_commands)
    canvas = parsed_commands.foldl(nil) do |canvas, command|
      yield edit(canvas: canvas, **command)
    end
    Success(canvas)
  end

  def edit(args)
    Editor.call(**args)
  end
end
