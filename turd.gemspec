# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "turd/version"

Gem::Specification.new do |s|
  s.name        = "turd"
  s.version     = Turd::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Stefan Penner"]
  s.email       = ["stefan.penner@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby/Rails Word Doc renderer}
  s.description = %q{When a client wants word docs rendered, and you dont feel like typing word 2003 xml by hand}

  s.rubyforge_project = "turd"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
