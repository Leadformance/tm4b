require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc "Run the test suite"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rspec_opts = ['--options', "spec/spec.opts"]
end
