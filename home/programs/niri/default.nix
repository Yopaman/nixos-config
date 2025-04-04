{ pkgs, config, niri, ... }:

{
  home.file.".config/niri/config.kdl".source = ./config.kdl;
  home.file.".config/wallpaper/wallpaper.png".source = ./wallpaper.png;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "~/.config/wallpaper/wallpaper.png";
      wallpaper = ",~/.config/wallpaper/wallpaper.png";
    };
  };
}
