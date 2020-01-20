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
	docker run --rm -v $(PWD)/tests:/tests stacks_ubuntu:test bash /tests/sanity.sh
	docker run --rm -v $(PWD)/tests:/tests stacks_ubuntu:test python3 /tests/numpy_test.py

test_debug:
	m4 -I $(TEMPLATES_DIR) stack/$(DISTRO)_functest/Dockerfile.m4 | tee stack/$(DISTRO)_functest/Dockerfile
	docker build -t stacks_$(DISTRO):test stack/$(DISTRO)_functest/
	docker run -it -v $(PWD)/tests:/tests stacks_ubuntu:test /bin/bash

clean:
	rm -rf helloworld/Dockerfile
	rm -rf stack/clearlinux/Dockerfile
	rm -rf stack/ubuntu/Dockerfile
