{
  inputs,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    ./programs
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  stylix = {
    enable = true;

    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    polarity = "dark";
    autoEnable = false;
    targets = {
      helix.enable = true;
      ghostty.enable = true;
      fish.enable = true;
    };
  };

  home = {
    username = "pablo";
    homeDirectory = "/home/pablo";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
