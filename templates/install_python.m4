ifelse(index(OS,`clearlinux'),-1,dnl
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python3,dnl
RUN swupd update --no-boot-update $swupd_args && swupd bundle-add python-basic)
