# bdockerimg &nbsp;&nbsp; [![CircleCI](https://dl.circleci.com/status-badge/img/circleci/UMKeFZ8ns9T9vi5aquTfVT/UnuEnZH2XpWqXouT1Vw6ud/tree/main.svg?style=shield&circle-token=8628d87e42f35713d28e416db33bd0980a4e7bd8)](https://dl.circleci.com/status-badge/redirect/circleci/UMKeFZ8ns9T9vi5aquTfVT/UnuEnZH2XpWqXouT1Vw6ud/tree/main) 

[![Matrix](https://img.shields.io/matrix/bdockerimg%3Amatrix.org?style=social&logo=matrix)](https://matrix.to/#/#bdockerimg:matrix.org) &nbsp;&nbsp;&nbsp; ![GitHub commit activity](https://img.shields.io/github/commit-activity/m/bahmanm/bdockerimg?style=social&logo=github) 

A collection of Docker images which are otherwise not easy to find.  
<img alt="bdockerimage logo" src="https://imgur.com/grb1Dqg.png" style="height: 300px; width: 300px; vertical-align: top" /> 

# 🖼️ Images

Here's the list of all images (in alaphabetical order:)

### 🖼️ [bmakelib](bmakelib/README.md) ![Docker Pulls](https://img.shields.io/docker/pulls/bdockerimg/bmakelib?style=social&logo=docker)
_bmakelib and GNU Make 4.4.x_

### 🖼️ [QuickLisp](quicklisp/README.md) ![Docker Pulls](https://img.shields.io/docker/pulls/bdockerimg/quicklisp?style=social&logo=docker)
_Vanilla QuickLisp using SBCL_

### 🖼️ [SDKMAN](sdkman/README.md) ![Docker Pulls](https://img.shields.io/docker/pulls/bdockerimg/sdkman?style=social&logo=docker)
_Vanilla SDKMAN_

# ⚛️ Fusions

_Read about [fusions](fusion/README.md) and why they are useful._

Here's the list of all fusions available:

### ⚛️ [QuickLisp . bmakelib](https://hub.docker.com/r/bdockerimg/quicklisp.bmakelib) ![Docker Pulls](https://img.shields.io/docker/pulls/bdockerimg/quicklisp.bmakelib?style=social&logo=docker)
_[QuickLisp](quicklisp/README.md) and [bmakelib](bmakelib/README.md)_

### ⚛️ [sdkman . bmakelib](https://hub.docker.com/r/bdockerimg/sdkman.bmakelib) ![Docker Pulls](https://img.shields.io/docker/pulls/bdockerimg/sdkman.bmakelib?style=social&logo=docker)
_[SDKMAN](sdkman/README.md) and [bmakelib](bmakelib/README.md)_


# On Quality

Each image is tested during the pipeline to ensure the tools are correctly installed and, in simplest form, they 
behave as they should.  Think "hello world" style tests.

That means, besides ensuring soundness of bdockerimg's pipeline, those tests should act as an extremely rudimentary form of 
catching regressions in the tools being packaged.

# How do I get a new image into bdockerimg?

Simply [create an issue](https://github.com/bahmanm/bdockerimg/issues/new) requesting the image or if you've got the time, create a pull request.

# Why bdockerimg?

I got tired of copy-paste'ing the same setup commands over and over, particulary in CI/CD pipelines. 
Additionally, I'm sure there are others who keep copy-paste'ing the same snippets.

Besides, it's quite fun!

  
