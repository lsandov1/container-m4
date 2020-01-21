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

