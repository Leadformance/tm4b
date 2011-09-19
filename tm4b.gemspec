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

  s.require_paths = ["lib"]

  s.summary = %q{TM4b HTTP API implementation}
  
  s.files = Dir.glob("lib/**/*.rb") + %w(Gemfile)
  s.test_files = Dir.glob("spec/**/*.rb")

  s.add_dependency "thor"
  
  s.add_development_dependency "rake"

  s.add_development_dependency "rspec", ">= 2.6.0"
  s.add_development_dependency "fakeweb", ">= 1.3.0"

  # to make testing more fun (if only it needed less configuration)
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  
  s.add_dependency "activesupport", "= 3.0.10"

  if RUBY_PLATFORM =~ /darwin/i
    # filesystem event support for OSX
    s.add_development_dependency "rb-fsevent"

    # system notifications for OSX
    s.add_development_dependency "growl_notify"
  end

  if RUBY_PLATFORM =~ /linux/i
    # filesystem event support for Linux
    s.add_development_dependency "rb-inotify"

    # system notifications for Linux
    s.add_development_dependency "libnotify"
  end

  if RUBY_PLATFORM =~ /mswin32/i
    # filesystem event support for Windows
    s.add_development_dependency 'rb-fchange'

    # console colours for Windows
    s.add_development_dependency 'win32console'

    # system notifications for Windows
    s.add_development_dependency 'rb-notifu'
  end

end

