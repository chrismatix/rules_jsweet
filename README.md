# Jsweet Bazel rules

This repository is a WIP with the intent of creating production grade Bazel rules for the [jsweet](http://www.jsweet.org/) Java to Javascript/Typescript compiler.

## Setup

To install these rules add this snippet to your `WORKSPACE` file:

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_jsweet",
    urls = ["https://github.com/xChrisPx/rules_jsweet/releases/download/0.1.0/rules_jsweet-0.1.0.zip"],
    sha256 = "8bcbbe63e4cd374ef6091d3005e435d76a9d1d4d2af847f8927c2331dfcaa715",
)

load("@rules_jsweet//:repositories.bzl", "rules_jsweet_dependencies")
rules_jsweet_dependencies()
```

