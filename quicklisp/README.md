# QuickLisp

A vanilla QuickLisp image (currently) using SBCL.

👉 [View on Docker Hub](https://hub.docker.com/r/bdockerimg/quicklisp)

# Variants

There are two main variants of the image for slightely different usecases:

* openSUSE Tumbleweed
* Ubuntu 22.04 (LTS)

# How to use

### ✔ One-off commands

```
＄ docker run --rm bdockerimg/quicklisp \
  --eval '(ql:quickload :alexandria)' \
  --eval '(format t "factorial(10) is ~A" (alexandria:factorial 10))'

This is SBCL 2.1.11.debian, an implementation of ANSI Common Lisp.
...
; Loading "alexandria"
[package alexandria]..............................
[package alexandria-2].

factorial(10) is 3628800
```

### ✔ Entire Lisp projects

To run [euler-cl](https://github.com/bahmanm/euler-cl):

```text
＄ git clone https://github.com/bahmanm/euler-cl.git && pushd euler-cl \
  && docker run --rm --volume .:/project bdockerimg/quicklisp \
  --eval "(ql:quickload :alexandria)" \
  --eval "(ql:quickload :fiveam)" \
  --eval "(ql:quickload :cl-ppcre)" \
  --eval "(setf asdf:*central-registry* (list* '*default-pathname-defaults* (car (directory #p\".\")) asdf:*central-registry*))" \
  --eval "(asdf:load-system :euler)" \
  --eval "(euler:solutions)"

Cloning into 'euler-cl'...
...
This is SBCL 2.1.11.debian, an implementation of ANSI Common Lisp.
...

 ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
 ┃                        PROJECT EULER ANSWERS                         ┃
 ┣━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━┫
 ┃ PROBLEM #  ┃              ANSWER              ┃      TIME (µs)       ┃
 ┣━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━┫
 ┃          1 │                          233,168 │                   61 ┃
 ┠────────────┼──────────────────────────────────┼──────────────────────┨
 ┃          2 │                        4,613,732 │                    2 ┃
 ┠────────────┼──────────────────────────────────┼──────────────────────┨
...
 ┗━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━━━━┛

```

### ✔ Scripting

```lisp
#!/usr/bin/env -S docker run --rm --volume .:/project bdockerimg/quicklisp --script

(load "~/.sbclrc")
(ql:quickload :str)
(format t "foo x5 is ~A"
        (str:repeat 5 "foo"))
```

### ✔ CI/CD pipeline

Here's a real world example of the image being used: [euler-cl CircleCI configuration](https://github.com/bahmanm/euler-cl/blob/8d027c83423e09c7e4d90bca815e7ed5da86775f/.circleci/config.yml#L10)

---

# What is QuickLisp?

> Quicklisp is a library manager for Common Lisp. It works with your existing Common Lisp
> implementation to download, install, and load any of over 1,500 libraries with a few simple
> commands.

https://www.quicklisp.org
