{ pkgs, ... }:
{
  services = {
    printing.enable = true;

    avahi = {
      enable = true;
      nssmdns6 = true;
      openFirewall = true;
    };

    gvfs.enable = true;

    # Configure keymap in X11
    xserver.xkb = {
      layout = "fr";
      variant = "oss";
    };

    upower.enable = true;

    # Greeter
    displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        keyboard = {
          layout = "fr";
        };
      };
    };

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

    netbird = {
      enable = true;
    };

    resolved.enable = true;

    mullvad-vpn.enable = true;
  };
}
