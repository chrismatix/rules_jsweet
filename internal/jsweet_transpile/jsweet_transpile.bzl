
ALLOWED_EXT = ".java"

def get_basename(input_file, trim):
    basename = "/".join(input_file.short_path.split("/")[trim:])
    if basename.endswith(ALLOWED_EXT):
        basename = basename[:-len(ALLOWED_EXT)]

    if basename[0] == "/":
        return basename[1:]

    return basename

def ts_out_dir_name(ctx):
    return ctx.genfiles_dir.path + "/" + ctx.label.package + "/target_ts"

def _outputs(ctx, input_files = []):
    label = ctx.label

    workspace_segments = label.workspace_root.split("/") if label.workspace_root else []
    package_segments = label.package.split("/") if label.package else []
    trim = len(workspace_segments) + len(package_segments)

    ts_gen_files = []
    for input_file in input_files:
        basename = get_basename(input_file, trim)
        gen_file = ctx.actions.declare_file("target_ts/" + basename + ".ts")
        ts_gen_files.append(gen_file)

    return struct(
        ts_gen_files = ts_gen_files,
    )

def _jsweet_transpile_impl(ctx):
    name = ctx.attr.name
    input_files = ctx.files.srcs
    print(ctx.label.package)

    outs = _outputs(ctx, input_files)

    jsweet_working_dir = ctx.actions.declare_directory("jsweet_workdir")
    transpiler = ctx.attr._jsweet_transpiler.files_to_run.executable
    nodejs_bin = ctx.toolchains["@build_bazel_rules_nodejs//toolchains/node:toolchain_type"].nodeinfo.tool_files[0]


    command = """
export PATH={node_path}:$PATH;
{transpiler} --workingDir {working_dir} --verbose --input {input_dirs} --tsOnly --tsout {ts_out} && \
cp -r {ts_out}/{package}/* {ts_out}/
""".format(
        node_path = nodejs_bin.path,
        package = ctx.label.package,
        transpiler = transpiler.path,
        input_dirs = ":".join([f.dirname for f in input_files]),
        working_dir = jsweet_working_dir.path,
        ts_out = ts_out_dir_name(ctx),
        out_file = outs.ts_gen_files[0].path
    )

    ctx.actions.run_shell(
        inputs = input_files,
        outputs = [jsweet_working_dir] + outs.ts_gen_files,
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
        DefaultInfo(
            runfiles = ctx.runfiles(
                # Note: don't include files=... here, or they will *always* be built
                # by any dependent rule, regardless of whether it needs them.
                # But these attributes are needed to pass along any input runfiles:
                collect_default = True,
                collect_data = True,
            ),
            files = depset(outs.ts_gen_files)
        ),
        OutputGroupInfo(
            ts_sources = depset(outs.ts_gen_files)
        )
    ]

_jsweet_transpile = rule(
    attrs = {
        "srcs": attr.label_list(
          allow_files = [ALLOWED_EXT]
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
