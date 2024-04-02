{ config, pkgs, ... }:

{
  # wayland.windowManager.hyprland.enable = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/mocha.conf".source = ./mocha.conf;
}
