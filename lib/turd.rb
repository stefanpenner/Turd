require 'erb'
require 'base64'
require 'mini_magick'

module Turd
  # An object from BlankSlate simply discards all messages sent to it.
  autoload :BasicObject, 'turd/basic_object.rb'
  autoload :Template,    'turd/template'
  autoload :Image,       'turd/image'
  autoload :Partial,     'turd/partial'
  autoload :Table,       'turd/table'
  autoload :Content,     'turd/content'
  autoload :Document,    'turd/document'

  autoload :Engine,      'turd/engine'
end

#eventually load a real renderer
Turd::Engine if defined? Rails
