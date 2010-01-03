make clean
rm Makefile ftd2xx.c
swig -ruby -autorename -o ftd2xx.c -I/usr/local/include ftd2xx.i
ruby extconf.rb
make