{ pkgs, ... }:

{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  networking.hostName = "desktop"; # Define your hostname.

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  services.desktopManager.plasma6 = {
    enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
