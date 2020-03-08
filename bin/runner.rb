#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'dry/cli'

require_relative '../lib/bitmap_editor'

class BitmapEditor
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class Version < Dry::CLI::Command
        desc 'Print version'

        def call(*)
          puts '1.0.0'
        end
      end

      class Process < Dry::CLI::Command
        desc 'Process bitmap editor commands'

        argument :command_file, required: true, desc: 'File with commands'

        example [
          'path/to/command/file # Start Foo at root directory'
        ]

        def call(command_file:, **)
          if File.exist?(command_file)
            BitmapEditor.new.run(command_file)
          else
            puts 'Target file does not exist'
            puts 'Exitting'
          end
        end
      end
      register 'version', Version, aliases: ['v', '-v', '--version']
      register 'run', Process
    end
  end
end

Dry::CLI.new(BitmapEditor::CLI::Commands).call
