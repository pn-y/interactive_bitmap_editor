# frozen_string_literal: true

require_relative '../lib/bitmap_editor'
require 'pry'

BitmapEditor.new.process ARGV.first
