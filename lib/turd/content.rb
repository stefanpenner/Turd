module Turd
  class Content
    module Tags

      def body(options = {})
        @output << "<w:body>"
        @output << center_property if options[:center]
        yield
        @output << "</w:body>"
      end

      def sect(options = {})
        @output << "<wx:sect>"
        @output << center_property if options[:center]
        yield
        @output << "</wx:sect>"
      end

      def h1(words)
        %{<w:p wsp:rsidR="004135AF" wsp:rsidRDefault="004A6C22">
            <w:pPr>
              <w:pStyle w:val="Heading1" />
            </w:pPr>
            <w:r>
              <w:t>#{words}</w:t>
            </w:r>
          </w:p>
        }
      end

      def p(words,defaults ={})
        color = defaults[:color] || "black"
       %{<w:p wsp:rsidR="004135AF" wsp:rsidRDefault="004A6C22">
          <w:r>
            <w:rPr>
              <w:color w:val="#{color}" />
            </w:rPr>
            <w:t>#{words}</w:t>
          </w:r>
        </w:p>}
      end

      def br
        p ""
      end

      def sub
        @output << "<wx:sub-section>"
        yield
        @output << "</wx:sub-section>"
      end
    end
  end
end
