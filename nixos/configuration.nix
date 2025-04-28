{
  inputs,
  lib,
  config,
  ...
}:
{
  # You can import other NixOS modules here
  imports = [
    ./programs.nix
    ./services.nix
    ./networking.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "olm-3.2.16"
      ];
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
    (lib.filterAttrs (_: lib.isType "flake")) inputs
  );

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  nix.settings.trusted-users = [
    "root"
    "pablo"
  ];

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
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "rtkit"
        "libvirtd"
        "vboxusers"
      ];
    };
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;

  boot.binfmt.emulatedSystems = [ "mips-linux" ];

  system.stateVersion = "23.05";
}
