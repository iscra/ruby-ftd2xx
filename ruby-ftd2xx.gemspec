require 'rubygems'
spec = Gem::Specification.new do |s|
  s.name = "ruby-ftd2xx"
  s.version = "0.0.2"
  s.authors = ["Pontus Strömdahl"]
  s.email = "pontus.stromdahl@adhocskill.com"
  s.homepage = "http://github.com/pfspontus/ruby-ftd2xx"
  s.platform = Gem::Platform::CURRENT
  s.summary = "A Ruby extension for the ftd2xx usb driver."
  s.files = ["ext/ftd2xx.c", "ext/extconf.rb","README.rdoc","LICENSE.txt","Rakefile"]
  s.require_path = "."
  s.extensions = ["ext/extconf.rb"]
  s.licenses = ['MIT']
end
