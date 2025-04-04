# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other home-manager modules here
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./programs
  ];

  home = {
    username = "pablo";
    homeDirectory = "/home/pablo";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    # Graphical Programs
    # ------------------

    # Network/Internet
    firefox
    ladybird
    qbittorrent

    # Medias
    spotify
    zathura
    mpv
    obs-studio

    # Social
    vesktop
    thunderbird

    # Dev
    zed-editor
    qemu
    imhex

    # Games
    prismlauncher

    # Desktop
    hyprlock
    swaynotificationcenter
    networkmanagerapplet
    nwg-displays
    xwayland-satellite
    anyrun
    waybar

    # Editors
    helix

    # Programming Languages
    rustup
    go
    nodejs_20
    zig
    python3
    clang-tools
    gcc
    gnumake
    nodePackages.eslint

    # Command Line Programs
    fastfetch
    ffmpeg
    slurp
    grim
    yt-dlp
    wl-clipboard
    btop
    zellij
    eza
    pandoc
    ripgrep
    hugo
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  catppuccin.enable = true;
  catppuccin.accent = "lavender";
  catppuccin.flavor = "mocha";


  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.catppuccin-cursors.mochaLavender;
    name = "Catppuccin-Mocha-Lavender-Cursors";
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
