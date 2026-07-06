{
  inputs,
  pkgs,
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
  ];

  nix = {
    # enable lix
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";
    autoEnable = false;
  };

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Slow "generating man cache" with fish
  documentation.man.cache.enable = false;

  # Configure console keymap
  console.keyMap = "fr";

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  users.users = {
    pablo = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "rtkit"
        "libvirtd"
        "vboxusers"
        "input"
      ];
      shell = pkgs.fish;
    };
  };

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
    };
  };
  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  boot.binfmt.emulatedSystems = [ "mips-linux" ];

  system.stateVersion = "23.05";
}
