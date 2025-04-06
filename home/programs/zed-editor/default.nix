{pkgs, config, ...}:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "catppuccin"
      "nix"
      "html"
    ];
  }
}
