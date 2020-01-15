define(OS, clearlinux)dnl
define(VER, latest)dnl
FROM OS:VER
include(update.m4)dnl
include(entrypoint.m4)dnl
