task :default => [:all]

task :all => [:build_gem]

task :build_gem => [:swig] do
  `gem build ruby-ftd2xx.gemspec`
end

task :swig => [:clean] do
  `cd ext`
  `swig -ruby -autorename -o ftd2xx.c -I/usr/local/include ../lib/ftd2xx.i`
  `ruby extconf.rb`
  `make`
  `cd ..`
end

task :clean do
  `cd ext`
  `make clean`
  `rm Makefile ftd2xx.c`
  `cd ..`
end