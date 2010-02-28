task :default => [:all]

task :all => [:build_gem]

desc "build gem file for distribution"
task :build_gem => [:swig] do
  `gem build ruby-ftd2xx.gemspec`
end

desc "let swig generate ftd2xx.c file (see http://swig.org)"
task :swig => [:clean] do
  FileUtils.cd "ext"
  `swig -ruby -autorename -o ftd2xx.c -I/usr/local/include ../lib/ftd2xx.i`
  `ruby extconf.rb`
  `make`
  FileUtils.cd ".."
end

desc "clean all generated files except gem file"
task :clean do
  FileUtils.cd "ext"
  if File.exist?("Makefile")
    `make clean`
    FileUtils.rm "Makefile"
  end
  FileUtils.rm "ftd2xx.c" if File.exist?("ftd2xx.c")
  FileUtils.cd ".."
end