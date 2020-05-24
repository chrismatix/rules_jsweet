load("//internal/transpile:jsweet_transpile.bzl", "jsweet_transpile")

java_library(
    name = "lib",
    srcs = ["src/java/com/github/rules_jsweet/examples/User.java"],
    deps = [
        "@maven//:org_jsweet_jsweet_core"
    ]
)

jsweet_transpile(
    name = "jsweet",
    srcs = ["src/java/com/github/rules_jsweet/examples/User.java"],
    deps = [
        "@maven//:org_jsweet_jsweet_core"
    ]
)
