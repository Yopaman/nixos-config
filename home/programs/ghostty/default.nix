{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      window-decoration = false;
      window-padding-x = 15;
      window-padding-y = 15;
      font-family = "JetBrainsMono Nerd Font";
      gtk-single-instance = true;
    };
  };
}
