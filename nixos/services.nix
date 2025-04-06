{ pkgs, ... }:
{
  services = {
    printing.enable = true;

    avahi = {
      enable = true;
      nssmdns6 = true;
      openFirewall = true;
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "fr";
        options = "eurosign:e, caps:escape";
      };
    };

    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    gvfs.enable = true;

    blueman.enable = true;

    # Sound configuration
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          		bluez_monitor.properties = {
          			["bluez5.enable-sbc-xq"] = true,
          			["bluez5.enable-msbc"] = true,
          			["bluez5.enable-hw-volume"] = true,
          			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
          		}
          	'')
      ];
    };

    openssh = {
      enable = true;
      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # Use keys only. Remove if you want to SSH using password (not recommended)
        PasswordAuthentication = false;
      };
    };


  };
}
