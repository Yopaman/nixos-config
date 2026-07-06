{
  lib,
  stdenv,
  fetchFromGitHub,
  zig,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "zine-ssg";
  version = "0.11.3";
  __structuredAttrs = true;
  strictDeps = true;

  src = fetchFromGitHub {
    owner = "kristoff-it";
    repo = "zine";
    tag = "v${finalAttrs.version}";
    hash = "sha256-ALC3vBetIX18eX8r7D/Mts/k7T+QxAGJFHZz2fqwCW0=";
  };

  nativeBuildInputs = [
    zig
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Fast, Scalable, Flexible Static Site Generator (SSG";
    homepage = "https://github.com/kristoff-it/zine";
    changelog = "https://github.com/kristoff-it/zine/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "zine-ssg";
    inherit (zig.meta) platforms;
  };
})
