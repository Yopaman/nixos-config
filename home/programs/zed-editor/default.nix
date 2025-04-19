{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "nix"
      "html"
    ];
    userSettings = {
      buffer_font_family = "JetBrainsMono Nerd Font";
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter = {
            external = {
              command = "nixfmt";
            };
          };
        };
      };
      lsp = {
        nil = {
          initialization_option = {
            formatting = {
              command = [ "nixfmt" ];
            };
          };
        };
      };
    };
  };
}
