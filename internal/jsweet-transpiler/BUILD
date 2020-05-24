package(default_visibility = ["//visibility:public"])

java_binary(
    name = "jsweet-transpiler",
    srcs = glob(["**/*.java"]),
    main_class = "com.github.rules_jsweet.JSweetCommandLineLauncher",
    deps = [
        "@maven//:org_jsweet_jsweet_transpiler",
        "@maven//:org_jsweet_jsweet_core",
        "@maven//:log4j_log4j",
        "@maven//:com_martiansoftware_jsap"
    ],
)
