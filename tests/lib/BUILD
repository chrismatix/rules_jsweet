load("@npm_bazel_typescript//:index.bzl", "ts_library")
load("//:defs.bzl", "jsweet_transpile", "jsweet_ts_lib")

java_library(
    name = "lib",
    srcs = ["com/github/rules_jsweet/examples/User.java"],
    deps = [
        "@maven//:org_jsweet_jsweet_core"
    ]
)

jsweet_transpile(
    name = "jsweet",
    srcs = ["com/github/rules_jsweet/examples/User.java"]
)

jsweet_ts_lib(
    name = "lib_ts",
    module_name = "user",
    srcs = ["com/github/rules_jsweet/examples/User.java"]
)


