{ pkgs, config, nix-colors, niri, ... }:

{
  programs.niri.enable = true;
  home.file.".config/niri/config.kdl".source = ./config.kdl;
}
