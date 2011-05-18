require 'open-uri'
module Turd
  class Image < Template
    def initialize(path, defaults = {})
      data = open(path) {|file| file.read }
      @image = MiniMagick::Image.read(data)
      resize_to_fit(defaults[:height],defaults[:width]) if defaults[:height] or defaults[:width]
      @data = Base64.encode64(data)
    end

    def resize_to_fit(height,width)
      actual_height, actual_width = @image[:height], @image[:width]

      height ||= actual_height
      width  ||= actual_width

      return [height,width] if height == actual_height and width == actual_width

      height_delta = height/actual_height.to_f
      width_delta  = width/actual_width.to_f

      larger_delta = height_delta.abs < width_delta.abs ? height_delta : width_delta

      @height = actual_height*larger_delta
      @width  = actual_width*larger_delta

      [@height,@width]
    end

    def template_file
      "image.xml.erb"
    end

    module Tags
      def image(path, args)
        Image.new(path,args).build
      end
    end
  end
end
