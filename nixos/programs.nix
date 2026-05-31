{ pkgs, inputs, ... }:
{
  programs = {
    # Fish shell
    fish.enable = true;
    bash = {
      interactiveShellInit = ''
        # "check if parent process is not fish" && "make nested shells work properly"
        if grep -qv fish /proc/$PPID/comm && [[ $SHLVL == [12] ]]; then
            # set $SHELL for better integration with programs like nix shell, tmux, etc.
            SHELL=${pkgs.fish}/bin/fish exec fish
        fi
      '';
    };

    steam.enable = true;
    gamemode.enable = true; # Improve game performances

    virt-manager.enable = true;

    ssh.startAgent = true;

    nix-ld.enable = true;

    firefox.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/user/nixos-config"; # sets NH_OS_FLAKE variable for you
    };

    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Network/Internet
    qbittorrent

    # Medias
    spotify
    zathura
    mpv
    obs-studio
    audacity

    # Social
    vesktop
    thunderbird

    # Cybersec
    autopsy
    sleuthkit
    ghidra
    #ida-free
    ligolo-ng
    avalonia-ilspy
    nmap
    (wordlists.override {
      lists = with pkgs; [
        rockyou
        seclists
        dirb
        dirbuster
      ];
    })
    john
    imhex
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
    volatility3
    bloodhound
    chisel
    proxychains
    hashcat
    wireshark

    # Games
    prismlauncher

    # Editors
    obsidian
    vim

    # Programming Languages
    rustup
    go
    zig
    (python3.withPackages (
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
        pyinstaller
      ]
    ))
    clang-tools
    gcc
    gnumake

    # LSP, linters, ...
    gopls
    nixd
    nil
    nixfmt
    nixpkgs-fmt
    ccls
    vscode-langservers-extracted
    htmx-lsp
    typescript-language-server
    prettierd
    stylua
    black
    zls
    eslint

    # Command Line Programs
    fastfetch
    distrobox
    ffmpeg
    yt-dlp
    comma
    nix-index
    wl-clipboard
    btop
    eza
    pandoc
    ripgrep
    file
    gdb
    asciinema
    wine
    wget
    curl
    efibootmgr
    killall
    pamixer
    cachix
    pavucontrol
    docker-compose
    dnsproxy
    home-manager
    zip
    unzip
    rar
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
    roboto
    hack-font
  ];
}
