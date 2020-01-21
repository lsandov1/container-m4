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

## Contributing
Pull requests are welcome. For major changes, please open an issue first to
discuss what you would like to change.

Please make sure to update tests as appropriate.

