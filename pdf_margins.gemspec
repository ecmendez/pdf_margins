$:.push File.expand_path("../lib", __FILE__)

require "pdf/margins/version"

Gem::Specification.new do |s|
  s.name        = "pdf_margins"
  s.version     = PDF::Margins::VERSION
  s.authors     = ["Tom Taylor"]
  s.email       = ["tom@newspaperclub.com"]
  s.homepage    = "https://github.com/newspaperclub/pdf_margins"
  s.summary     = "Simple library to checks whether the margins are clear in a PDF"
  s.license     = "MIT"

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "chunky_png", "~> 1.2.8"
  s.add_dependency "oily_png", "~> 1.1.0"

  s.add_development_dependency "rake"
  s.add_development_dependency "test-unit"
end
