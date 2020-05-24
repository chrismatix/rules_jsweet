load("//internal/jsweet_transpile:jsweet_transpile.bzl", "jsweet_transpile","TRANSPILE_ATTRS")
load("@npm_bazel_typescript//:index.bzl", "ts_library")

JWSEET_TRANSPILE_KEYS = TRANSPILE_ATTRS.keys()

def jsweet_ts_lib(name, **kwargs):
    transpile_args = dict()
    for transpile_key in JWSEET_TRANSPILE_KEYS:
        if transpile_key in kwargs:
            value = kwargs.pop(transpile_key)
            if value != None:
                transpile_args[transpile_key] = value

    jsweet_transpiled_name = name + "_jsweet_transpiled"

    jsweet_transpile(
        name = jsweet_transpiled_name,
        **transpile_args
    )

    jsweet_ts_sources_name = name + "_jsweet_ts_sources"

    native.filegroup(
        name = jsweet_ts_sources_name,
        srcs = [":" + jsweet_transpiled_name],
        output_group = "ts_sources"
    )

    ts_library(
        name = name,
        srcs = [":" + jsweet_ts_sources_name],
        **kwargs # The remaining arguments go to `ts_library`
    )
