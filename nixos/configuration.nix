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
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  nix.settings.trusted-users = [ "root" "pablo" ];

  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;
  networking.firewall.checkReversePath = false;

  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    DISPLAY = ":0";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    EDITOR = "nvim";
  };

  # Slow "generating man cache" with fish
  documentation.man.generateCaches = false;


  services.gvfs.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  users.users = {
    pablo = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [ "wheel" "networkmanager" "audio" "rtkit" "libvirtd" ];
    };
  };


  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    efibootmgr
    git
    inotify-tools
    killall
    pamixer
    libmpc
    cachix
    distrobox
    xdg-desktop-portal-gtk
    xwayland-satellite
    inputs.agenix.packages."${system}".default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    font-awesome
    roboto
    hack-font
  ];

  virtualisation.libvirtd.enable = true;

  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
