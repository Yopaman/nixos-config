{ config, pkgs, ... }:

{
  # wayland.windowManager.hyprland.enable = true;
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
  home.file.".config/hypr/mocha.conf".source = ./mocha.conf;
  home.file.".config/hypr/wallpaper.jpeg".source = ./wallpaper.jpeg;
  home.file.".config/hypr/wallpaper.png".source = ./wallpaper.png;
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
  home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
}
