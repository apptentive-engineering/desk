source "http://rubygems.org"

gemspec


group :development do
  if RUBY_VERSION < "2.0"
    gem "ruby-debug"
  else
    gem "byebug"
  end
end

group :test do
  if RUBY_VERSION < "2.0"
    gem "ruby-debug"
  else
    gem "byebug"
  end
end
