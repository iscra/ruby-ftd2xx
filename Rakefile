task :default => [:all]

task :all => [:build_gem]

task :build_gem => [:swig] do
  `gem build ruby-ftd2xx.gemspec`
end

task :swig => [:clean] do
  FileUtils.cd "ext"
  `swig -ruby -autorename -o ftd2xx.c -I/usr/local/include ../lib/ftd2xx.i`
  `ruby extconf.rb`
  `make`
  FileUtils.cd ".."
end

task :clean do
  FileUtils.cd "ext"
  if File.exist?("Makefile")
    `make clean`
    FileUtils.rm "Makefile"
  end
  FileUtils.rm "ftd2xx.c" if File.exist?("ftd2xx.c")
  FileUtils.cd ".."
end