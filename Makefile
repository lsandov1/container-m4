.PHONY: helloworld stack stack/clearlinux stack/ubuntu

TEMPLATES_DIR=templates
DISTRO=ubuntu
MOCK_CONFIG ?= "epel-6-i386"
TEST=sanity.sh
all: helloworld stack

helloworld:
	m4 -I $(TEMPLATES_DIR) $@/Dockerfile.m4 | tee $@/Dockerfile

stack: stack/clearlinux stack/ubuntu

stack/clearlinux stack/ubuntu:
	m4 -I $(TEMPLATES_DIR) $@/Dockerfile.m4 | tee $@/Dockerfile

test:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)/Dockerfile_functest.m4 | tee stack/$(DISTRO)/Dockerfile_functest
	docker build -t stacks_$(DISTRO):test -f stack/$(DISTRO)/Dockerfile_functest .
	docker run --rm -v $(PWD)/tests:/tests stacks_$(DISTRO):test /tests/$(TEST)

test_debug:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)/Dockerfile_functest.m4 | tee stack/$(DISTRO)/Dockerfile_functest
	docker build -t stacks_$(DISTRO):test -f stack/$(DISTRO)/Dockerfile_functest .
	docker run -it -v $(PWD)/tests:/tests stacks_$(DISTRO):test /bin/bash

bench:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)/Dockerfile_perftest.m4 | tee stack/$(DISTRO)/Dockerfile_perftest
	docker build -t stacks_$(DISTRO):perf -f stack/$(DISTRO)/Dockerfile_perftest .
	docker run --rm -v $(PWD)/tests:/tests stacks_$(DISTRO):perf bash /tests/phpbench.sh

bench_debug:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)/Dockerfile_perftest.m4 | tee stack/$(DISTRO)/Dockerfile_perftest
	docker build -t stacks_$(DISTRO):perf -f stack/$(DISTRO)/Dockerfile_funtest .
	docker run -it -v $(PWD)/tests:/tests stacks_$(DISTRO):perf /bin/bash

package:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)/Dockerfile_mock.m4 \
		| tee stack/centos/Dockerfile
	mkdir -p rpmbuild/
	docker build -t stacks_centos:mock stack/centos/
	docker run --privileged -it \
		-v $(PWD)/rpmbuild:/rpmbuild \
		-e MOCK_CONFIG=$(MOCK_CONFIG) \
		-e SOURCE_RPM=$(SRPM) \
		-e SOURCES=$(SOURCES) \
		-e SPEC_FILE=$(SPEC_FILE) \
		stacks_centos:mock /bin/bash
clean:
	rm -rf helloworld/Dockerfile
	rm -rf stack/clearlinux/Dockerfile
	rm -rf stack/ubuntu/Dockerfile
