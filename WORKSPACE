workspace(
    name = "rules_jsweet",
    managed_directories = {"@npm": ["node_modules"]},
)

load("//:respositories.bzl", "rules_jsweet_dependencies")

rules_jsweet_dependencies()

### jvm_external (https://github.com/bazelbuild/rules_jvm_external)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        "org.jsweet:jsweet-core:6.2.0",
        "org.jsweet:jsweet-transpiler:3.0.0-RC1",
        "com.martiansoftware:jsap:2.1"
        ],
    repositories = [
        "https://packages.confluent.io/maven",
        "http://repository.jsweet.org/artifactory/libs-release-local/",
        "https://repo1.maven.org/maven2/",
    ],
    maven_install_json = "//:maven_install.json"
)

load("@maven//:defs.bzl", "pinned_maven_install")
pinned_maven_install()

### rules_nodejs (https://github.com/bazelbuild/rules_nodejs)

load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    # Name this npm so that Bazel Label references look like @npm//package
    name = "npm",
    package_json = "//:package.json",
    yarn_lock = "//:yarn.lock",
)

load("@npm//:install_bazel_dependencies.bzl", "install_bazel_dependencies")

install_bazel_dependencies()

load("@npm_bazel_typescript//:index.bzl", "ts_setup_workspace")
ts_setup_workspace()
