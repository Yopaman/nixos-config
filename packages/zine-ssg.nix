# packages/zine-ssg.nix
#
# Zine, plus the editor tooling documented at
# https://zine-ssg.io/docs/editors/helix/
#
# Ships three CLIs (zine, ziggy, superhtml) and, under
# $out/share/helix/runtime, a Helix runtime overlay holding the compiled
# tree-sitter grammars and their Helix-flavoured queries:
#
#   $out/share/helix/runtime/grammars/<language>.so
#   $out/share/helix/runtime/queries/<language>/*.scm
#
# Symlinking those into ~/.config/helix/runtime replaces the docs' manual
# clone + `hx --grammar build` steps. See home/programs/helix/default.nix.
{
  lib,
  stdenv,
  fetchurl,
  fetchFromGitHub,
}:
let
  version = "0.13.0";

  # Versions pinned by zine v0.13.0's build.zig.zon. The tree-sitter grammars at
  # these release tags are byte-identical to the commits zine pins.
  ziggyVersion = "0.2.0";
  superhtmlVersion = "0.7.0";
  # supermd has no releases; this is the commit zine v0.13.0 depends on.
  supermdRev = "da528ac38e6940d23b7c2bf611ccf01fe6231e82";

  fetchBin =
    {
      repo,
      rev,
      hash,
    }:
    fetchurl {
      url = "https://github.com/kristoff-it/${repo}/releases/download/${rev}/x86_64-linux-musl.tar.xz";
      inherit hash;
    };

  zineBin = fetchBin {
    repo = "zine";
    rev = "v${version}";
    hash = "sha256-wlDgKdl4kBsMmjjqsKhg7524db9ob+Dwq/YfGAwoDbo=";
  };

  ziggyBin = fetchBin {
    repo = "ziggy";
    rev = "v${ziggyVersion}";
    hash = "sha256-GSn8+S1vC7UiPLlATBwt53Ci/yVsfYXdXinpFfRemNI=";
  };

  superhtmlBin = fetchBin {
    repo = "superhtml";
    rev = "v${superhtmlVersion}";
    hash = "sha256-t1xu7vU5QWCW6sOHKe5U5fOySPA5yrT1dmDymoh0L2g=";
  };

  ziggySrc = fetchFromGitHub {
    owner = "kristoff-it";
    repo = "ziggy";
    rev = "v${ziggyVersion}";
    hash = "sha256-luLYcGQ/2yi5SZbv1l7Be9LcizqiZdJY1i6TuxqFLdg=";
  };

  superhtmlSrc = fetchFromGitHub {
    owner = "kristoff-it";
    repo = "superhtml";
    rev = "v${superhtmlVersion}";
    hash = "sha256-bbRqwIdSNgHTNsPZzn+pf/9ix02rT3BXRB6uszaPdi4=";
  };

  supermdSrc = fetchFromGitHub {
    owner = "kristoff-it";
    repo = "supermd";
    rev = supermdRev;
    hash = "sha256-hqMJ4EXIgaNvWALfplYUr5NnpYv/W8IhWCZcLsRftE8=";
  };

  # Helix language name -> where its parser and its Helix queries live upstream.
  # supermd keeps two flavours of queries around; the ones next to the parser
  # are the neovim capture names, the Helix ones live under editors/helix.
  grammars = {
    ziggy = {
      parser = "${ziggySrc}/tree-sitter-ziggy";
      queries = "${ziggySrc}/tree-sitter-ziggy/queries";
    };
    ziggy_schema = {
      parser = "${ziggySrc}/tree-sitter-ziggy-schema";
      queries = "${ziggySrc}/tree-sitter-ziggy-schema/queries";
    };
    supermd = {
      parser = "${supermdSrc}/tree-sitter/supermd";
      queries = "${supermdSrc}/editors/helix/queries/supermd";
    };
    supermd_inline = {
      parser = "${supermdSrc}/tree-sitter/supermd-inline";
      queries = "${supermdSrc}/editors/helix/queries/supermd_inline";
    };
    superhtml = {
      parser = "${superhtmlSrc}/tree-sitter-superhtml";
      queries = "${superhtmlSrc}/tree-sitter-superhtml/queries";
    };
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "zine-ssg";
  inherit version;

  srcs = [
    zineBin
    ziggyBin
    superhtmlBin
  ];

  sourceRoot = ".";

  dontConfigure = true;
  dontBuild = true;
  # The upstream binaries are statically linked musl builds.
  dontPatchELF = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    for bin in zine ziggy superhtml; do
      install -Dm755 "$(find . -type f -name "$bin" | head -n1)" "$out/bin/$bin"
    done

    runtime="$out/share/helix/runtime"
    mkdir -p "$runtime/grammars" "$runtime/queries"

    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (language: g: ''
        cp -r ${g.queries} "$runtime/queries/${language}"
        $CC -shared -fPIC -O2 -I ${g.parser}/src \
          ${g.parser}/src/parser.c \
          ${lib.optionalString (builtins.pathExists "${g.parser}/src/scanner.c") "${g.parser}/src/scanner.c"} \
          -o "$runtime/grammars/${language}.so"
      '') grammars
    )}
    chmod -R u+w "$runtime/queries"

    runHook postInstall
  '';

  passthru = {
    inherit ziggyVersion superhtmlVersion supermdRev;
    # Merge into ~/.config/helix/runtime to teach Helix about the Zine formats.
    helixRuntime = "${finalAttrs.finalPackage}/share/helix/runtime";
    helixLanguages = lib.attrNames grammars;
  };

  meta = {
    description = "Fast, Scalable, Flexible Static Site Generator (SSG), with the ziggy and superhtml language servers and Helix tree-sitter grammars";
    homepage = "https://github.com/kristoff-it/zine";
    changelog = "https://github.com/kristoff-it/zine/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    mainProgram = "zine";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
  };
})
