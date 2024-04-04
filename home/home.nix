# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  nix-colors,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    nix-colors.homeManagerModules.default
    ./programs
  ];

  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;

  home = {
    username = "pablo";
    homeDirectory = "/home/pablo";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
    # Graphical Programs
    firefox
    alacritty
    wofi
    dolphin
    discord
    zathura

    # Desktop
    swww
    hypridle
    hyprlock
    swaynotificationcenter
    networkmanagerapplet

    # Editors 
    helix

    # Programming Languages 
    rustup
    go
    gopls
    nil
    nodejs_20
    zig
    python3
    ccls
    clang-tools
    gcc
    gnumake
    racket
    

    # Misc
    fastfetch
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
