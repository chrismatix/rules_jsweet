load("@npm_bazel_typescript//:index.bzl", "ts_library")
load("//internal/jsweet_transpile:jsweet_transpile.bzl", "jsweet_transpile")

java_library(
    name = "lib",
    srcs = ["src/java/com/github/rules_jsweet/examples/User.java"],
    deps = [
        "@maven//:org_jsweet_jsweet_core"
    ]
)

jsweet_transpile(
    name = "jsweet",
    srcs = ["src/java/com/github/rules_jsweet/examples/User.java"]
)

filegroup(
    name = "ts_sources",
    srcs = [":jsweet"],
    output_group = "ts_sources"
)

ts_library(
    name = "lib_ts",
    srcs = [":ts_sources"]
)

