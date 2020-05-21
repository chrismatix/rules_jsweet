load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_JVM_EXTERNAL_TAG = "3.0"
RULES_JVM_EXTERNAL_SHA = "62133c125bf4109dfd9d2af64830208356ce4ef8b165a6ef15bbff7460b35c3a"

http_archive(
    name = "rules_jvm_external",
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    sha256 = "62133c125bf4109dfd9d2af64830208356ce4ef8b165a6ef15bbff7460b35c3a",
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:defs.bzl", "maven_install")

maven_install(
    artifacts = [
        "org.jsweet:jsweet-transpiler:2.3.7",
        "info.picocli:picocli:4.3.2",
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
