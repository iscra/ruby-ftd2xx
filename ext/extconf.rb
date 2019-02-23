require "mkmf"

extension_name = "ftd2xx"
dir_config(extension_name)
$LDFLAGS << " -lftd2xx"
create_makefile(extension_name)
