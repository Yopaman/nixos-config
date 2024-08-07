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
    inputs.catppuccin.homeManagerModules.catppuccin
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
    discord
    vesktop
    thunderbird

    # Dev
    alacritty
    wezterm
    zed-editor
    godot_4
    qemu
    neovide
    imhex

    # Games
    prismlauncher

    # Latex
    texliveSmall

    # Desktop
    xfce.thunar
    wofi
    fuzzel
    hyprlock
    swaynotificationcenter
    networkmanagerapplet
    nwg-displays
    avizo
    hyprcursor
    gparted

    # Editors
    helix

    # Programming Languages
    # ---------------------
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

    # Command Line Programs
    # ---------------------
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
