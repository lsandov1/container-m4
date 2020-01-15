define(CLR, clearlinux)dnl
define(VER, latest)dnl
FROM CLR:VER
include(update.m4)dnl
include(entrypoint.m4)dnl
