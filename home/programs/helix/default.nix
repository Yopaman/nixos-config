{
  pkgs,
  lib,
  ...
}:
let
  zine-ssg = pkgs.callPackage ./../../../packages/zine-ssg.nix { };
  zineRuntime = "${zine-ssg}/share/helix/runtime";
in
{
  programs.helix = {
    enable = true;

    defaultEditor = true;

    # Puts zine, ziggy and superhtml on Helix's PATH, for the language servers
    # and formatters configured below.
    extraPackages = [ zine-ssg ];

    settings = {
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };

    languages = {
      # Zine tooling — https://zine-ssg.io/docs/editors/helix/
      language-server = {
        ziggy-lsp = {
          command = "ziggy";
          args = [ "lsp" ];
        };
        ziggy-schema-lsp = {
          command = "ziggy";
          args = [
            "lsp"
            "--schema"
          ];
        };
        superhtml-lsp = {
          command = "superhtml";
          args = [ "lsp" ];
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
        }

        # Ziggy
        {
          name = "ziggy";
          scope = "text.ziggy";
          roots = [ ];
          injection-regex = "ziggy|zgy";
          file-types = [
            "ziggy"
            "zgy"
          ];
          comment-token = "//";
          auto-format = true;
          formatter = {
            command = "ziggy";
            args = [
              "fmt"
              "--stdin"
            ];
          };
          language-servers = [ "ziggy-lsp" ];
        }
        {
          name = "ziggy_schema";
          scope = "text.ziggy_schema";
          roots = [ ];
          injection-regex = "ziggy-schema|zgy-schema";
          file-types = [
            "ziggy-schema"
            "zgy-schema"
            { glob = ".ziggy-schema"; }
          ];
          comment-token = "///";
          indent = {
            tab-width = 4;
            unit = "    ";
          };
          auto-format = true;
          formatter = {
            command = "ziggy";
            args = [
              "fmt"
              "-"
              "--type"
              "schema"
            ];
          };
          language-servers = [ "ziggy-schema-lsp" ];
        }

        # SuperMD
        {
          name = "supermd";
          scope = "source.supermd";
          roots = [ ];
          file-types = [ "smd" ];
          injection-regex = "supermd|smd";
        }
        {
          name = "supermd_inline";
          scope = "source.supermd.inline";
          injection-regex = "supermd_inline";
          file-types = [ ];
          grammar = "supermd_inline";
        }

        # SuperHTML
        {
          name = "html";
          scope = "source.html";
          roots = [ ];
          file-types = [ "html" ];
          language-servers = [ "superhtml-lsp" ];
        }
        {
          name = "superhtml";
          scope = "source.superhtml";
          roots = [ ];
          file-types = [ "shtml" ];
          injection-regex = "superhtml|shtml";
          auto-format = true;
          language-servers = [ "superhtml-lsp" ];
        }
      ];
    };
  };

  # The zine-ssg package ships the tree-sitter grammars already compiled, along
  # with their Helix queries, so linking them into the runtime directory covers
  # the docs' "link all queries" and "hx --grammar build" steps. Helix still
  # falls back to its bundled runtime for every other language.
  xdg.configFile = lib.mergeAttrsList (
    map (language: {
      "helix/runtime/grammars/${language}.so".source = "${zineRuntime}/grammars/${language}.so";
      "helix/runtime/queries/${language}".source = "${zineRuntime}/queries/${language}";
    }) zine-ssg.passthru.helixLanguages
  );
}
