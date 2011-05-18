module Turd
  class Partial < Template
    attr_accessor :template_file, :content
    def initialize(template_file,content=nil)
      @template_file = template_file
      @content = content
    end

    def template_file
      @template_file
    end
  end
end
