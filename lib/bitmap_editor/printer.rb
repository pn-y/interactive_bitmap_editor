# frozen_string_literal: true

class BitmapEditor
  class Printer
    class << self
      def call(canvas)
        canvas.rows.each do |row|
          row.each do |value|
            print value
          end
          print "\n"
        end
      end
    end
  end
end
