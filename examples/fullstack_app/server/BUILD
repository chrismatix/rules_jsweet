
java_binary(
    name = "server",
    srcs = glob(["**/*.java"]),
    main_class = "com.github.rules_jsweet.examples.Application",
    resources = glob(["src/resources/**/*"]),
    deps = [
        "@maven//:io_micronaut_micronaut_runtime",
        "@maven//:io_micronaut_micronaut_validation",
        "@maven//:io_micronaut_micronaut_inject",
        "@maven//:io_micronaut_micronaut_http",
        "@maven//:io_micronaut_micronaut_http_client",
        "@maven//:io_micronaut_micronaut_http_server_netty",
        "@maven//:ch_qos_logback_logback_classic",
        "@maven//:javax_annotation_javax_annotation_api"
    ],
)
