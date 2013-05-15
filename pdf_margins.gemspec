$:.push File.expand_path("../lib", __FILE__)

require "pdf/margins/version"

Gem::Specification.new do |s|
  s.name        = "pdf_margins"
  s.version     = PDF::Margins::VERSION
  s.authors     = ["Tom Taylor"]
  s.email       = ["tom@newspaperclub.com"]
  s.homepage    = "http://www.newspaperclub.com"
  s.summary     = "Checks a PDF for margin spacing"

  s.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rmagick", "~> 2.13.2"

  s.add_development_dependency "rake"
  s.add_development_dependency "test-unit"
end
