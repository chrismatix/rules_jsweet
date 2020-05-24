
def _jsweet_transpile_impl(ctx):
    name = ctx.attr.name

    input_dirs = depset([f.dirname for f in ctx.files.srcs])

    ts_out_dir = ctx.actions.declare_directory("target_ts")
    jsweet_working_dir = ctx.actions.declare_directory("jsweet_workdir")

    transpiler = ctx.attr._jsweet_transpiler.files_to_run.executable

    nodejs_bin = ctx.toolchains["@build_bazel_rules_nodejs//toolchains/node:toolchain_type"].nodeinfo.tool_files[0]

    command = """
export PATH={node_path}:$PATH;
{transpiler} --workingDir {working_dir}  --input {files} --tsOnly --tsout {ts_out}
""".format(
        node_path = nodejs_bin.path,
        transpiler = transpiler.path,
        files = ":".join(input_dirs.to_list()),
        working_dir = jsweet_working_dir.path,
        ts_out = ts_out_dir.path
    )

    inputs = ctx.files.srcs + ctx.files._jdk

    ctx.actions.run_shell(
        inputs = inputs,
        outputs = [ts_out_dir, jsweet_working_dir],
        command = command,
        progress_message = "compiling java files to typescript",
        tools = [
            transpiler,
            nodejs_bin
        ],
        mnemonic = "JSweetCompile",
        arguments = [],
      )

    return [
       DefaultInfo(files = depset([ts_out_dir, jsweet_working_dir]))
    ]

_jsweet_transpile = rule(
    attrs = {
        "srcs": attr.label_list(
          allow_files = [".java"]
        ),
        "_jdk": attr.label(
          default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
          allow_files = True,
          providers = [java_common.JavaRuntimeInfo]
        ),
        "deps": attr.label_list(
            providers = [JavaInfo]
        ),
        "_jsweet_transpiler": attr.label(
            cfg = "host",
            executable = True,
            default = "//internal/jsweet-transpiler"
        ),
    },
    implementation = _jsweet_transpile_impl,
    toolchains = [
        # We need access to node
        # https://github.com/bazelbuild/rules_nodejs/blob/master/internal/node/test/nodejs_toolchain_test.bzl
        "@build_bazel_rules_nodejs//toolchains/node:toolchain_type"
    ],
)

def jsweet_transpile(
    name,
    deps = [],
    **kwargs
):

    _jsweet_transpile(
        name = name,
        deps = deps,
        **kwargs
    )
