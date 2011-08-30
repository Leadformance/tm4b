# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2, :cli => "--color", :notification => true do
  # run the suite for any changes to the specs
  watch(%r{^spec/.+_spec\.rb$})

  # run all specs for any changes to lib/ files (simple for now)
  watch(%r{^lib/(.+)\.rb$}) { Dir.glob("spec/**/*_spec.rb") }

  # run the suite for changes to the helper
  watch('spec/spec_helper.rb')
end
