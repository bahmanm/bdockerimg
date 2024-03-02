# bmakelib

A lightweight image of bmakelib and GNU Make 4.4

👉 [View on Docker Hub](https://hub.docker.com/r/bdockerimg/bmakelib)

# Variants

There are two main variants of the image for slightely different usecases:

* openSUSE Tumbleweed
* Ubuntu 22.04 (LTS)

# How to use

### ✔ Build entire projects

```
＄ ls 
main.c  Makefile


＄ cat Makefile
include  bmakelib/bmakelib.mk

binary := build/simple

build/ :
	mkdir -p $(@)

.PHONY : build
build : $(binary)

$(binary) : bmakelib.default-if-blank( CC,gcc )
$(binary) : main.c | build/
	$(CC) -o $(@) $(<)

.PHONY : run
run : build
	@$(binary)

.PHONY : clean
clean :
	-rm -rf build/


＄ cat main.c
#include <stdio.h>

int main(void) {
     printf("Hello, world\n");
     return 0;
}

＄ docker run --rm --volume .:/project bdockerimg/bmakelib run
mkdir -p build/
cc -o build/simple main.c
Hello, world
```

### ✔ Scripting

```
＄ cat my-cool-script
#!/usr/bin/env -S docker run --rm --volume .:/project bdockerimg/bmakelib -j 1 -k -f

include bmakelib/bmakelib.mk

.DEFAULT_GOAL := main

.PHONY : foo
foo : bmakelib.error-if-blank( kernel )
foo :
	@echo $(@): Running kernel $(kernel)

.PHONY : bar
bar : kernel := $(call bmakelib.shell.error-if-nonzero,uname -r)
bar : foo
bar :
	@echo $(@): Hello, world

.PHONY : baz
baz :
	@echo $(@): Tada

.PHONY : main
main : bar baz

＄ ./my-cool-script
foo: Running kernel 6.7.6-1-default
bar: Hello, world
baz: Tada
```

### ✔ CI/CD pipeline

Here's a real world example of the image being used: [bjforth CircleCI configuration](https://github.com/bahmanm/bjforth/blob/master/.circleci/config.yml#L8)

----

# What is bmakelib?

> The minimalist Make standard library you'd always wished for!
> bmakelib is essentially a collection of useful targets, recipes and variables you can use to 
> augment your Makefiles.
> The aim is not to simplify writing Makefiles but rather help you write cleaner and easier to 
> read and maintain Makefiles.

https://github.com/bahmanm/bmakelib
