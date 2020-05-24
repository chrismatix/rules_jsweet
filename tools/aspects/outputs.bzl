# Some ready to use aspects that can be helpful for understanding the outputs of external rules

def _output_group_query_aspect_impl(target, ctx):
  for og in target.output_groups:
    print("output group " + str(og) + ": " + str(getattr(target.output_groups, og)))
  return []

# Use this aspect to discover all output groups of a rule. Example:
# bazel build --nobuild TARGET --aspects=//tools/aspects:outputs.bzl%output_group_query_aspect
output_group_query_aspect = aspect(
    implementation = _output_group_query_aspect_impl,
)

# ["actions", "data_runfiles", "default_runfiles", "files", "files_to_run", "java", "label", "output_groups"]
def _provider_query_aspect_impl(target, ctx):
  print(target.actions)
  print(target.data_runfiles)
  print(target.files)
  print(target.files_to_run)
  print(target.java)
  print(target.label)
  print(target.output_groups)

  return []

provider_query_aspect_impl = aspect(
    implementation = _provider_query_aspect_impl,
)
