# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, lib
, config
, pkgs
, nix-colors
, ...
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
    xfce.thunar
    discord
    zathura
    pandoc
    mongodb-compass
    zed-editor
    qemu
    mpv
    flameshot
    lapce

    # Latex
    texliveSmall

    # Desktop
    swww
    hypridle
    hyprlock
    swaynotificationcenter
    networkmanagerapplet
    nwg-displays

    # Editors
    helix
    zellij

    # Programming Languages
    rustup
    go
    nodejs_20
    zig
    python3
    clang-tools
    gcc
    gnumake
    racket
    nodePackages.eslint

    # Command Line programs
    fastfetch
    ffmpeg
    slurp
    grim
    yt-dlp
    wl-clipboard
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors;
    name = "mochaLavender";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Lavender-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "compact";
        variant = "mocha";
      };
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Lavender-Cursors";
      package = pkgs.catppuccin-cursors.mochaLavender;
      size = 20;
    };
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      vscodevim.vim
    ];
  };


  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
