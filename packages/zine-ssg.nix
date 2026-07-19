# packages/zine.nix
{
  lib,
  stdenvNoCC,
  fetchurl,
}:
let
  version = "0.11.3";
in
stdenvNoCC.mkDerivation {
  pname = "zine-ssg";
  inherit version;

  src = fetchurl {
    url = "https://github.com/kristoff-it/zine/releases/download/v${version}/x86_64-linux-musl.tar.xz";
    hash = "sha256-wl5Tcril0nWfK35YGu+5DIAZ/wBWojCpfv48jtqzvBk=";
  };

  sourceRoot = ".";

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 "$(find . -type f -name zine | head -n1)" "$out/bin/zine"
    runHook postInstall
  '';

  meta = {
    description = "Fast, Scalable, Flexible Static Site Generator (SSG)";
    homepage = "https://github.com/kristoff-it/zine";
    changelog = "https://github.com/kristoff-it/zine/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "zine";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
  };
}
