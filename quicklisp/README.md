# QuickLisp

A vanilla QuickLisp image (currently) using SBCL.

👉 [View on Docker Hub](https://hub.docker.com/r/bdockerimg/quicklisp)

# Variants

There are two main variants of the image for slightely different usecases:

* openSUSE Tumbleweed
* Ubuntu 22.04 (LTS)

# How to use

### ✔ One-off commands

For example, using the openSUSE Tumbleweed variant:

```
＄ docker run --rm bdockerimg/quicklisp:sbcl-2.4.2--opensuse-tumbleweed --eval '(format t "Hello, world")'

This is SBCL 2.4.2-1.1-suse, an implementation of ANSI Common Lisp.
...

Hello, world
```

### ✔ Lisp projects

Assuming you've saved the overly elborate below snippet at `~/lisp/foo.lisp`:

```lisp
(require :uiop)

(defun greet (name)
  (format t "Hello, ~A" name))

(let ((name (car (uiop:command-line-arguments))))
  (greet name))
```

The following command, uses the image to load and execute the file:

```
＄ docker run --rm --volume ~/tmp/lisp:/project bdockerimg/quicklisp:sbcl-2.1.11--ubuntu-2204 --load foo.lisp world

This is SBCL 2.1.11.debian, an implementation of ANSI Common Lisp.
...

Hello, world
```

### ✔ Scripting

```
#!/usr/bin/env -S docker run --rm --volume .:/project bdockerimg/quicklisp:sbcl-2.4.2--opensuse-tumbleweed --script

(format t "Hello, world")
```

### ✔ CI/CD pipeline

Here's a real world example of the image being used: [euler-cl CircleCI configuration](https://github.com/bahmanm/euler-cl/blob/8d027c83423e09c7e4d90bca815e7ed5da86775f/.circleci/config.yml#L10)

---

# What is QuickLisp?

> Quicklisp is a library manager for Common Lisp. It works with your existing Common Lisp
> implementation to download, install, and load any of over 1,500 libraries with a few simple
> commands.

https://www.quicklisp.org
