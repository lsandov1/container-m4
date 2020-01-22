all:hello

hello: main.c
	gcc main.c -o hello

install: hello
	mkdir -p \${prefix}/usr/local/bin
	cp hello \${prefix}/usr/local/bin
