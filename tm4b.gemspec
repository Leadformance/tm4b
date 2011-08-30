# -*- encoding: utf-8 -*-
require File.expand_path("lib/tm4b/version", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name = %q{tm4b}
  s.version = TM4B::Version::STRING
  s.platform = Gem::Platform::RUBY

  s.authors = ["William Howard"]
  s.email = %q{whoward.tke@gmail.com}
  s.homepage = %q{http://github.com/Leadformance/tm4b}

  s.default_executable = %q{tm4b}
  s.executables = ["tm4b"]

  s.extra_rdoc_files = ["README.markdown"]

  s.require_paths = ["lib"]

  s.summary = %q{TM4b HTTP API implementation}
  
  s.files = Dir.glob("lib/**/*.rb") + %w(Gemfile Gemfile.lock)
  s.test_files = Dir.glob("spec/**/*.rb")
  
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_development_dependency "fakeweb", "~> 1.3.0"
end

