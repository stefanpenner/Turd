module Turd
  class Document < Template
    def template_file
      "document.xml.erb"
    end

    def word
      @output = Partial.new("word.xml.erb",yield).build
    end

    def center_property
      '<w:pPr><w:jc w:val="center"/></w:pPr>'
    end

    include Image::Tags
    include Table::Tags
    include Content::Tags

  end
end
