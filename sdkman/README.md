# 🖼️ SDKMAN ![Docker Pulls](https://img.shields.io/docker/pulls/bdockerimg/sdkman?style=social&logo=docker)

A slim image of SDKMAN!.

👉 [View on Docker Hub](https://hub.docker.com/r/bdockerimg/sdkman)

# Variants

There are two main variants of the image for slightly different usecases:

* openSUSE Tumbleweed
* Ubuntu 22.04 (LTS)

# How to use

### ✔ Build entire projects

```
＄ ls 
app  gradle  gradle.properties  gradlew  gradlew.bat  settings.gradle


＄ docker run --rm --volume .:/project bdockerimg/sdkman 'sdk install java 17.0.10-tem && ./gradlew check'

Downloading: java 17.0.10-tem
...
Installing: java 17.0.10-tem
Done installing!
...
Welcome to Gradle 8.3!
...
BUILD SUCCESSFUL in 38s
3 actionable tasks: 3 executed
```

### ✔ CI/CD pipeline

Here's a real world example of the image being used: [persianutils CircleCI configuration](https://github.com/bahmanm/persianutils/blob/master/.circleci/config.yml#L10)

----

# What is SDKMAN?

> Your reliable companion for effortlessly managing multiple Software Development Kits on Unix
> systems. Imagine having different versions of SDKs and needing a stress-free way to switch between
> them. SDKMAN! steps in with its easy-to-use Command Line Interface (CLI) and API.

https://sdkman.io/
