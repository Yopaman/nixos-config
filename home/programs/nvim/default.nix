{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    # extraPython3Packages = pkgs: with pkgs; [ pil ];
  };
  home.file.".config/nvim" = {
    source = ./nvim-config;
    recursive = true;
  };
}
