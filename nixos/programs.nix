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
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    efibootmgr
    git
    killall
    pamixer
    cachix
    distrobox
    pavucontrol
    docker-compose
    dnsproxy
    home-manager
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
    roboto
    hack-font
  ];
}
