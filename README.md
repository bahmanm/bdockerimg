# bdockerimg [![CircleCI](https://dl.circleci.com/status-badge/img/circleci/UMKeFZ8ns9T9vi5aquTfVT/UnuEnZH2XpWqXouT1Vw6ud/tree/main.svg?style=shield&circle-token=8628d87e42f35713d28e416db33bd0980a4e7bd8)](https://dl.circleci.com/status-badge/redirect/circleci/UMKeFZ8ns9T9vi5aquTfVT/UnuEnZH2XpWqXouT1Vw6ud/tree/main)

A collection of Docker images which are otherwise not easy to find.  

# Images

Here's the list of all images (in alaphabetical order:)

⭐ [bmakelib](bmakelib/README.md):  bmakelib and GNU Make 4.4.x

⭐ [QuickLisp](quicklisp/README.md):  Vanilla QuickLisp using SBCL

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

  
