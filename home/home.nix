# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.nixvim.homeManagerModules.nixvim
    ./programs
  ];

  home = {
    username = "pablo";
    homeDirectory = "/home/pablo";
  };

  catppuccin.enable = true;
  catppuccin.accent = "lavender";
  catppuccin.flavor = "mocha";

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
