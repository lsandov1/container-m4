.PHONY: helloworld stack stack/clearlinux stack/ubuntu

TEMPLATES_DIR=templates
DISTRO=ubuntu
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

clean:
	rm -rf helloworld/Dockerfile
	rm -rf stack/clearlinux/Dockerfile
	rm -rf stack/ubuntu/Dockerfile
