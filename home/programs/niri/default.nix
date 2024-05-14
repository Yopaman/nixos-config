{ pkgs, config, nix-colors, niri, ... }:

{
  home.file.".config/niri/config.kdl".source = ./config.kdl;
}
