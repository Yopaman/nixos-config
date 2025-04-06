{ inputs
, lib
, config
, pkgs
, ...
}:
{
  imports = [
    ./alacritty
    ./waybar
    ./nvim
    ./fish
    ./starship
    ./helix
    ./swaync
    ./niri
    ./ghostty
    ./anyrun
    ./zed-editor
  ];

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
    qemu
    imhex

    # Cybersec
    ghidra
    ligolo-ng
    nmap
    seclists
    john
    burpsuite
    samba
    responder
    smbmap
    inetutils
    openldap


    # Games
    prismlauncher

    # Desktop
    hyprlock
    hypridle
    swaynotificationcenter
    networkmanagerapplet
    nwg-displays
    anyrun
    waybar

    # Editors
    helix
    obsidian

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

    # LSP, linters, ...
    gopls
    nixd
    nixpkgs-fmt
    ccls
    vscode-langservers-extracted
    htmx-lsp
    nodePackages_latest.typescript-language-server
    prettierd
    stylua
    black
    zls
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Pablo";
    userEmail = "contact@pablo.town";
  };
}
