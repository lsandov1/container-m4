ifelse(index(OS,`clearlinux'),-1,dnl
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y phoronix-test-suite zip,dnl
RUN swupd update --no-boot-update $swupd_args && swupd bundle-add phoronix-test-suite)
