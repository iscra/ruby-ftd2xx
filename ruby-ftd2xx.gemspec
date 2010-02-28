require 'rubygems'
spec = Gem::Specification.new do |s|
  s.name = "ruby-ftd2xx"
  s.version = "0.0.1"
  s.author = "Pontus Strömdahl"
  s.email = "pontus.stromdahl@adhocskill.com"
  s.homepage = "http://github.com/pfspontus/ruby-ftd2xx"
  s.platform = Gem::Platform::CURRENT
  s.summary = "A Ruby extension for the ftd2xx usb driver."
  s.files = ["ext/ftd2xx.c", "ext/extconf.rb"]
  s.require_path = "."
  s.extensions = ["ext/extconf.rb"]
end
if $0 == __FILE__
  Gem::Builder.new(spec).build
end