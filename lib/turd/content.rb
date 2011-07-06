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
            <wx:font  wx:val="#{font_name}"/>
          </w:rPr>
        }
      end

      def font(name=nil)
        name ||= @default_font

        (@font_stack ||= []).push name
        @default_font = name
        yield
        @default_font = @font_stack.pop
      end

      def bold_tag
        %{
            <w:rPr>
              <w:b/>
            </w:rPr>
        }
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

      def h1(words,options={})
        %{<w:p wsp:rsidR="004135AF" wsp:rsidRDefault="004A6C22">
            <w:pPr>
              <w:pStyle w:val="Heading1" />
            </w:pPr>
            <w:r>
              #{option_tags(options)}
              <w:t>#{escape(words)}</w:t>
            </w:r>
          </w:p>
        }
      end

      def option_tags(options)
        color     = options[:color] || 'Black'
        font_name = options[:font]
        style     = options[:style]

        output = ""
        output << color_tag(color)    if color
        output << font_tag(font_name) if font_name
        output << bold_tag            if style == "bold"

        output
      end

      def b(word,options={})
        %{<w:r wsp:rsidRPr="00B7092C">
            <w:rPr>
              <w:b/>
            </w:rPr>
            #{option_tags(options)}
            <w:t>#{escape(word)}</w:t>
          </w:r>}
      end

      def p(words="",options={})
       %{<w:p wsp:rsidR="004135AF" wsp:rsidRDefault="004A6C22">
          <w:r>
            #{option_tags(options)}
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
