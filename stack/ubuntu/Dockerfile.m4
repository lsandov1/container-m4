define(OS, ubuntu)dnl
define(VER, 16.04)dnl
FROM OS:VER
include(update.m4)dnl
include(entrypoint.m4)dnl
