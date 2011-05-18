require 'rubygems'
require 'pathname'
root = Pathname.new File.expand_path("../", __FILE__)

$:.unshift  root + "../lib/"

require 'turd'

if __FILE__ == $PROGRAM_NAME
  puts Turd::Document.new(root + "document.xml.erb" ).build
end
