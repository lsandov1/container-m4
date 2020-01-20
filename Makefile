.PHONY: helloworld stack stack/clearlinux stack/ubuntu

TEMPLATES_DIR=templates
DISTRO=ubuntu

all: helloworld stack

helloworld:
	m4 -I $(TEMPLATES_DIR) $@/Dockerfile.m4 | tee $@/Dockerfile

stack: stack/clearlinux stack/ubuntu

stack/clearlinux stack/ubuntu:
	m4 -I $(TEMPLATES_DIR) $@/Dockerfile.m4 | tee $@/Dockerfile

test:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)_functest/Dockerfile.m4 | tee stack/$(DISTRO)_functest/Dockerfile
	docker build -t stacks_$(DISTRO):test stack/$(DISTRO)_functest/
	docker run --rm -v $(PWD)/tests:/tests stacks_$(DISTRO):test bash /tests/sanity.sh
	docker run --rm -v $(PWD)/tests:/tests stacks_$(DISTRO):test python3 /tests/numpy_test.py

test_debug:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)_functest/Dockerfile.m4 | tee stack/$(DISTRO)_functest/Dockerfile
	docker build -t stacks_$(DISTRO):test stack/$(DISTRO)_functest/
	docker run -it -v $(PWD)/tests:/tests stacks_$(DISTRO):test /bin/bash

bench:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)_perftest/Dockerfile.m4 | tee stack/$(DISTRO)_perftest/Dockerfile
	docker build -t stacks_$(DISTRO):perf stack/$(DISTRO)_perftest/
	docker run --rm -v $(PWD)/tests:/tests stacks_$(DISTRO):perf bash /tests/phpbench.sh

bench_debug:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)_perftest/Dockerfile.m4 | tee stack/$(DISTRO)_perftest/Dockerfile
	docker build -t stacks_$(DISTRO):perf stack/$(DISTRO)_perftest/
	docker run -it -v $(PWD)/tests:/tests stacks_$(DISTRO):perf /bin/bash

clean:
	rm -rf helloworld/Dockerfile
	rm -rf stack/clearlinux/Dockerfile
	rm -rf stack/ubuntu/Dockerfile
