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
      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
      };
    };
  };
}
