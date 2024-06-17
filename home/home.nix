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
    firefox
    thunderbird
    spotify
    alacritty
    wezterm
    xfce.thunar
    discord
    vesktop
    zathura
    pandoc
    zed-editor
    qemu
    mpv
    obs-studio
    godot_4
    blender
    prismlauncher
    neovide
    ladybird

    # Latex
    texliveSmall

    # Desktop
    wofi
    fuzzel
    anyrun
    hyprlock
    swaynotificationcenter
    networkmanagerapplet
    nwg-displays
    catppuccin-cursors
    avizo

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
    btop
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

  gtk = {
    enable = true;
    # theme = {
    #   name = "Catppuccin-Mocha-Compact-Lavender-Dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = [ "lavender" ];
    #     size = "compact";
    #     variant = "mocha";
    #   };
    # };
    #
    # cursorTheme = {
    #   name = "Catppuccin-Mocha-Lavender-Cursors";
    #   package = pkgs.catppuccin-cursors.mochaLavender;
    #   size = 20;
    # };
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
