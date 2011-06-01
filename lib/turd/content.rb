require 'cgi'
module Turd
  class Content
    module Tags

      def escape(words)
         CGI.escapeHTML(words)
      end

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
              <w:t>#{escape(words)}</w:t>
            </w:r>
          </w:p>
        }
      end

      def b(word)
        %{<w:r wsp:rsidRPr="00B7092C">
            <w:rPr>
              <w: b/>
            </w:rPr>
            <w:t>#{escape(word)}</w:t>
          </w:r>}
      end

      def p(words,defaults ={})
        color = defaults[:color] || "black"
       %{<w:p wsp:rsidR="004135AF" wsp:rsidRDefault="004A6C22">
          <w:r>
            <w:rPr>
              <w:color w:val="#{color}" />
            </w:rPr>
            <w:t>#{escape(words)}</w:t>
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
