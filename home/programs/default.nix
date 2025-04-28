{
  inputs,
  lib,
  config,
  pkgs,
  ...
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
    qbittorrent
    nheko

    # Medias
    spotify
    zathura
    mpv
    obs-studio
    audacity

    # Social
    vesktop
    thunderbird

    # Dev
    imhex
    gnome-boxes

    # Cybersec
    autopsy
    sleuthkit
    ghidra
    ida-free
    ligolo-ng
    nmap
    seclists
    john
    burpsuite
    samba
    smbmap
    inetutils
    openldap
    netexec
    kerbrute
    steghide
    stegseek
    zsteg
    binwalk
    binaryninja-free
    (cutter.withPlugins (
      ps: with ps; [
        cutterPlugins.rz-ghidra
      ]
    ))
    inputs.pwndbg.packages.${system}.default
    volatility3

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
    xdg-desktop-portal-gnome

    # Editors
    helix
    obsidian

    # Programming Languages
    rustup
    go
    nodejs_20
    zig
    (python312.withPackages (
      python-pkgs: with python-pkgs; [
        pandas
        requests
        pwntools
        impacket
        tqdm
        pycryptodome
        pygame
        numpy
        fontfeatures
        fonttools
        harfbuzz
        uharfbuzz
      ]
    ))
    clang-tools
    gcc
    gnumake
    nodePackages.eslint

    # LSP, linters, ...
    gopls
    nixd
    nil
    nixfmt-rfc-style
    nixpkgs-fmt
    ccls
    vscode-langservers-extracted
    htmx-lsp
    nodePackages_latest.typescript-language-server
    prettierd
    stylua
    black
    zls

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
    file
    gdb
    asciinema

    # SDL
    SDL2
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Pablo";
    userEmail = "contact@pablo.town";
  };
}
