module Turd
  class Template < BasicObject
    def initialize(object,template_path)
      @object = object
      @_template_path = template_path
    end

    def template_file
      @_template_path or raise "specify file"
    end

    def self.root
      Pathname.new File.expand_path("../../templates/", __FILE__)
    end

    def self.read(path)
      open(root + path).read
    end

    def read(path)
      Template.read path
    end

    def render(file)
      read file
    end

    def raw_template
      @_template ||= read template_file
    end

    def template
      ERB.new raw_template, nil, nil, "@output"
    end

    def build
      template.result(binding)
    end
  end
end
