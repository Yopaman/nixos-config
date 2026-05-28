{ pkgs, inputs, ... }:
{
  programs = {
    # Fish shell
    fish.enable = true;
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
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
