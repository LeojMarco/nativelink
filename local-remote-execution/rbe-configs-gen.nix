{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule rec {
  pname = "bazel-toolchains";
  version = "5.1.3-rc1";

  patches = [
    ./rbe_configs_gen_adjustments.diff
  ];

  src = fetchFromGitHub {
    owner = "bazelbuild";
    repo = "bazel-toolchains";
    rev = "v${version}";
    sha256 = "sha256-uHSZN6sThX0i1kAvMyaSIghs6kV0t7wgOA7IWVJksEo=";
  };

  vendorHash = "sha256-E6PylI2prXCXqOUYgYi5nZ4qptqOqbcaOquDfEkhaQ4=";

  meta = with lib; {
    description = "Generate Bazel toolchain configs for remote execution.";
    homepage = "https://github.com/bazelbuild/bazel-toolchains";
    license = licenses.asl20;
    maintainers = [maintainers.aaronmondal];
  };
}
[target.aarch64-pc-windows-msvc]
rustflags = [
    "-C", "target-feature=+crt-static", # Static CRT for 64-bit ARM Windows
    "-C", "link-arg=/NODEFAULTLIB:libcmt" # Avoid automatic dynamic CRT linking
]

[target.x86_64-pc-windows-msvc]
rustflags = [
    "-C", "target-feature=+crt-static", # Static CRT for 64-bit x86 Windows
    "-C", "link-arg=/NODEFAULTLIB:libcmt" # Avoid automatic dynamic CRT linking
]
