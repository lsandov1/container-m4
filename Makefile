.PHONY: helloworld stack stack/clearlinux stack/ubuntu

TEMPLATES_DIR=templates

all: helloworld stack

helloworld:
	m4 -I $(TEMPLATES_DIR) $@/Dockerfile.m4 | tee $@/Dockerfile

stack: stack/clearlinux stack/ubuntu

stack/clearlinux stack/ubuntu:
	m4 -I $(TEMPLATES_DIR) $@/Dockerfile.m4 | tee $@/Dockerfile
