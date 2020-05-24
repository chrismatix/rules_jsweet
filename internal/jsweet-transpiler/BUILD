package(default_visibility = ["//visibility:public"])

java_binary(
    name = "jsweet-transpiler",
    srcs = ["src/java/com/github/rules_jsweet/Main.java"],
    main_class = "org.jsweet.JSweetCommandLineLauncher",
    deps = [
        "@maven//:org_jsweet_jsweet_transpiler",
        "@maven//:org_jsweet_jsweet_core"
    ],
)
