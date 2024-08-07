# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration

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

  services.printing.enable = true;

  services.avahi = {
      enable = true;
      nssmdns6 = true;
      openFirewall = true;
    };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
  };



  # need to install hyprland system wide to make it appear on display managers
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "fr";
  services.xserver.xkb.options = "eurosign:e,caps:escape";


  # Sound configuration
  sound.enable = true;
  services.pipewire = {
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

  # Fish shell
  programs.fish.enable = true;
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.steam.enable = true;


  services.gvfs.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

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
    niri
    (catppuccin-kde.override { flavour = [ "mocha" ]; })
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" "Monaspace" "Noto" ]; })
    font-awesome
    roboto
    hack-font
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;


  programs.ssh.startAgent = true;
  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     # Forbid root login through SSH.
  #     PermitRootLogin = "no";
  #     # Use keys only. Remove if you want to SSH using password (not recommended)
  #     PasswordAuthentication = false;
  #   };
  # };

  virtualisation.containers.enable = true;
  virtualisation.podman.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
