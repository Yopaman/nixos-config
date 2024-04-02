{ pkgs, config, ... }:

{
  programs.alacritty.enable = true;
  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  home.file.".config/alacritty/catppuccin-mocha.toml".source = ./catppuccin-mocha.toml;
}
