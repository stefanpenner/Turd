module Turd
  class Table
    module Tags
      def table(defaults ={})
        border_color = defaults[:border_color] || "auto"
        border_width = defaults[:border_width] || 10
        @output << %{
          <w:tbl>
            <w:tblPr>
              <w:tblW w:w="0" w:type="auto" />
              <w:tblBorders>
                <w:top w:val="single" w:sz="4"      wx:bdrwidth="#{border_width}"
                w:space="0" w:color="#{border_color}" />
                <w:left w:val="single" w:sz="4"     wx:bdrwidth="#{border_width}"
                w:space="0" w:color="#{border_color}" />
                <w:bottom w:val="single" w:sz="4"   wx:bdrwidth="#{border_width}"
                w:space="0" w:color="#{border_color}" />
                <w:right w:val="single" w:sz="4"    wx:bdrwidth="#{border_width}"
                w:space="0" w:color="#{border_color}" />
                <w:insideH w:val="single" w:sz="4"  wx:bdrwidth="#{border_width}"
                w:space="0" w:color="#{border_color}" />
                <w:insideV w:val="single" w:sz="4"  wx:bdrwidth="#{border_width}"
                w:space="0" w:color="#{border_color}" />
              </w:tblBorders>
              <w:tblLook w:val="04A0" />
            </w:tblPr>
            <w:tblGrid>
              <w:gridCol w:w="4428" />
              <w:gridCol w:w="4428" />
            </w:tblGrid>
        }
        yield
        @output << "</w:tbl>"
      end

      def tr
        @output << %{<w:tr wsp:rsidR="00D2695C" wsp:rsidTr="004A6C22">}
        yield
        @output << %{</w:tr>}
      end

      def td(words,options={})
        %{
        <w:tc>
          <w:tcPr>
            <w:tcW w:w="4428" w:type="dxa" />
            <w:shd w:val="clear" w:color="auto" w:fill="auto" />
          </w:tcPr>
          <w:p wsp:rsidR="00D2695C" wsp:rsidRDefault="00D2695C"
          wsp:rsidP="00D2695C">
            <w:r>
              #{option_tags(options)}
              <w:t>#{escape(words)}</w:t>
            </w:r>
          </w:p>
        </w:tc>
        }
      end
    end
  end
end
