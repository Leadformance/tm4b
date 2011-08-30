source "http://rubygems.org"

gemspec

# to make testing more fun (if only it needed less configuration)
gem 'guard'
gem 'guard-rspec'

# filesystem event support for OSX
gem 'rb-fsevent' if RUBY_PLATFORM =~ /darwin/i

# filesystem event support for Linux
gem 'rb-inotify' if RUBY_PLATFORM =~ /linux/i

# filesystem event support and console colours for Windows
gem 'rb-fchange' if RUBY_PLATFORM =~ /mswin32/i
gem 'win32console' if RUBY_PLATFORM =~ /mswin32/i

# gems which support using system notifications (popup bubbles)
group :notifications do
   gem 'growl_notify' if RUBY_PLATFORM =~ /darwin/i
   gem 'libnotify'    if RUBY_PLATFORM =~ /linux/i
   gem 'rb-notifu'    if RUBY_PLATFORM =~ /mswin32/i
end