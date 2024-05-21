{ pkgs, ... }:

{
  imports = [
    # Hardware scan
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sdc";
  boot.loader.grub.useOSProber = true;
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  networking.hostName = "desktop"; # Define your hostname.

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  services.desktopManager.plasma6 = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    (catppuccin-kde.override { flavour = ["mocha"]; })
  ];
}
