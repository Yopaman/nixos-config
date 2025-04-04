{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./programs.nix
    ./services.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  nix.settings.trusted-users = [ "root" "pablo" ];

  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;
  networking.firewall = {
    enable = true;
    checkReversePath = false;
    allowedTCPPorts = [ 1337 ];
  };

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  environment.sessionVariables = {
    # QT_QPA_PLATFORM = "wayland";
    # DISPLAY = ":0";
    # _JAVA_AWT_WM_NONREPARENTING = "1";
    EDITOR = "nvim";
  };

  # Slow "generating man cache" with fish
  documentation.man.generateCaches = false;


  services.gvfs.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  users.users = {
    pablo = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = [ "wheel" "networkmanager" "audio" "rtkit" "libvirtd" ];
    };
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;

  system.stateVersion = "23.05";
}
