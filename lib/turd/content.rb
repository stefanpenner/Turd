require 'cgi'
module Turd
  class Content
    module Tags

      def escape(words='')
         CGI.escapeHTML(words.to_s)
      end

      def font_tag(font_name=nil)
        font_name ||= @default_font
        return unless font_name
        %{
          <w:rPr>
            <w:rFonts w:ascii="#{font_name}" w:h-ansi="#{font_name}"/>
            <wx:font wx:val="#{font_name}"/>
          </w:rPr>
        }
      end

      def font(name=nil)
        name ||= @default_font

        # we need a stack!
        previous_default_font = @default_font
        @default_font = name
        yield
        @default_font = previous_default_font
      end

      def color_tag(color)
        return unless color
        %{
          <w:rPr>
            <w:color w:val="#{color}" />
          </w:rPr>
        }
      end

      def body(options = {})
        font_name = options[:font]
        @output << "<w:body>"
        @output << center_property if options[:center]
        font(font_name) { yield }
        @output << "</w:body>"
      end

      def sect(options = {})
        font_name = options[:font]
        @output << "<wx:sect>"
        @output << center_property if options[:center]
        font(font_name) { yield }
        @output << "</wx:sect>"
      end

      def h1(words,defaults={})
        color      = defaults[:color] || "black"
        font_name  = defaults[:font]
        %{<w:p wsp:rsidR="004135AF" wsp:rsidRDefault="004A6C22">
            <w:pPr>
              <w:pStyle w:val="Heading1" />
            </w:pPr>
            <w:r>
              #{color_tag(color)}
              #{font_tag(font_name)}
              <w:t>#{escape(words)}</w:t>
            </w:r>
          </w:p>
        }
      end

      def b(word,defaults={})
        color      = defaults[:color] || "black"
        font_name  = defaults[:font]
        %{<w:r wsp:rsidRPr="00B7092C">
            <w:rPr>
              <w: b/>
            </w:rPr>
            #{color_tag(color)}
            #{font_tag(font_name)}
            <w:t>#{escape(word)}</w:t>
          </w:r>}
      end

      def p(words="",defaults ={})
        color      = defaults[:color] || "black"
        font_name  = defaults[:font]
       %{<w:p wsp:rsidR="004135AF" wsp:rsidRDefault="004A6C22">
          <w:r>
            #{color_tag(color)}
            #{font_tag(font_name)}
            <w:t>#{escape(words)}</w:t>
          </w:r>
        </w:p>}
      end

      def br
        p
      end

      def sub(defaults={})
        font_name = defaults[:font_name]
        @output << "<wx:sub-section>"
        font(font_name) { yield }
        @output << "</wx:sub-section>"
      end
    end
  end
end
