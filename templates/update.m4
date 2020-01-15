ifelse(index(OS,`clearlinux'),-1,dnl
RUN DEBIAN_FRONTEND=noninteractive apt-get update,dnl
RUN swupd update --no-boot-update $swupd_args)
