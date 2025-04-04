{ config, pkgs, ... }:
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

    # Desktop
    niri.enable = true;
    xwayland.enable = true;
    
    steam.enable = true;

    virt-manager.enable = true;
    
    ssh.startAgent = true;
  };
}
