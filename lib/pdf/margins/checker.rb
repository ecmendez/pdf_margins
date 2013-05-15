require 'pdf/margins/issue'
require 'RMagick'

module PDF
  module Margins
    class Checker

      MM_TO_PTS = 2.83464567
      DEFAULT_RESOLUTION = 72
      # If we find that we need higher resolution for better precision then we
      # can adjust the SCALE_MULTIPLIER at the cost of speed.
      SCALE_MULTIPLIER = 1 
      RESOLUTION = DEFAULT_RESOLUTION * SCALE_MULTIPLIER

      attr_reader :file, :top_margin, :left_margin, :bottom_margin, :right_margin

      # Dimensions are in mm, to be converted to PDF points later.
      def initialize(file, top_margin, left_margin, bottom_margin, right_margin)
        @file          = file
        @top_margin    = top_margin
        @left_margin   = left_margin
        @bottom_margin = bottom_margin
        @right_margin  = right_margin
      end

      def issues
        image_list = Magick::Image.read(file) do
          # Force CMYK colorspace, because ImageMagick autodetects PDF colorspace
          # depending on the contents of the file. By forcing the colorspace we
          # ensure that the subsequent checks in the `dirty_pixels?` method work.
          self.colorspace = Magick::CMYKColorspace
          self.density    = RESOLUTION
          self.antialias  = false
        end

        image_list.each_with_index.map do |image, index|

          page_number = index + 1
          [].tap do |page_issues|
            if dirty_pixels?(top_pixels(image, top_margin))
              page_issues << Issue.new(page_number, :top)
            end

            if dirty_pixels?(bottom_pixels(image, bottom_margin))
              page_issues << Issue.new(page_number, :bottom)
            end

            # Newspaper Club assumes that pages are two up, printed as spreads,
            # so we only check right margins on odd numbered pages, and left
            # margins on even numbered pages. This should probably be
            # a configurable option for other types of printing.
            if page_number % 2 == 0
              if dirty_pixels?(left_pixels(image, left_margin))
                page_issues << Issue.new(page_number, :left)
              end
            else
              if dirty_pixels?(right_pixels(image, right_margin))
                page_issues << Issue.new(page_number, :right)
              end
            end
          end
        end.flatten
      end

      private

      def mm_to_pixels(mm)
        (mm * MM_TO_PTS * SCALE_MULTIPLIER).floor
      end

      def top_pixels(image, mm)
        width_px = mm_to_pixels(mm)
        image.get_pixels(0, 0, image.columns, width_px)
      end

      def left_pixels(image, mm)
        width_px = mm_to_pixels(mm)
        image.get_pixels(0, 0, width_px, image.rows)
      end

      def right_pixels(image, mm)
        width_px = mm_to_pixels(mm)
        x = image.columns - width_px
        image.get_pixels(x, 0, width_px, image.rows)
      end

      def bottom_pixels(image, mm)
        width_px = mm_to_pixels(mm)
        y = image.rows - width_px
        image.get_pixels(0, y, image.columns, width_px)
      end

      def dirty_pixels?(pixels)
        pixels.any? do |p|
          (p.cyan | p.magenta | p.yellow | p.black) > 0
        end
      end

    end
  end
end

