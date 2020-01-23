# Containers-M4

Containers-M4 is a set of tools/scripts to automatically create Dockerfiles
based on M4 templates

## Usage

* Create the Dockerfiles for stacks

```bash
make
```

* Create a Dockerfile for functional test

```bash
make test DISTRO=ubuntu TEST=sanity.sh
```

DISTRO: variable to set OS image, for now only ubuntu/clearlinux are supported
TEST:	variable to set TEST to execute. Tests cases can live under tests/

* Create a Dockerfile for performance tests

```bash
make bench DISTRO=ubuntu
```

or

```bash
make bench DISTRO=clearlinux
```

The benchmark tests can live under tests/
The phoronix-test-suite framework are installed on the image if required

## Proxy

If you are behind a proxy please remember to configure Docker to use a proxy
server following the next documentation:

https://docs.docker.com/network/proxy/

Also for the performance tests the phoronix test suite needs to configure the
proxy on the user-config.xml:

```bash
diff --git a/tests/user-config.xml b/tests/user-config.xml
index f31a690..81dbadc 100644
--- a/tests/user-config.xml
+++ b/tests/user-config.xml
@@ -54,8 +54,8 @@
     <Networking>
       <NoNetworkCommunication>FALSE</NoNetworkCommunication>
       <Timeout>20</Timeout>
-      <ProxyAddress></ProxyAddress>
-      <ProxyPort></ProxyPort>
+      <ProxyAddress>my-proxy-home.com</ProxyAddress>
+      <ProxyPort>my-port</ProxyPort>
     </Networking>
     <Server>
       <RemoteAccessPort>-1</RemoteAccessPort>
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to
discuss what you would like to change.

Please make sure to update tests as appropriate.

## Build custom packages

This project also gives the capability to build custom pkgs. These packages
could be optimized for performance. In any case, the approach to follow is:

* For CentOS providing the SRPM

```
make package DISTRO=centos SRPM=git-2.3.0-1.el7.centos.src.rpm
```

The SRPM should be under rpmbuild, in this example the
[git-srpm](https://copr-be.cloud.fedoraproject.org/results/snoopotic/git-rpms/epel-7-x86_64/git-2.3.0-1.el6/git-2.3.0-1.el7.centos.src.rpm)
is used

This will prompt the recent image generated with mock ready to run, from there the user can execute the script:

```
[root@816581bfb8eb /]# ./build-rpm.sh
```

This will create the RPMs under:

```
./rpmbuild/output/
```

Mock will resolve all the build dependencies and keep a cache for future builds

Variables that user can adapt:

```
MOCK_CONFIG="epel-6-i386"
```
Mock config specifies the repositories from where to get the build dependencies

