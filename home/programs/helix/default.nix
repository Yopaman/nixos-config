{ pkgs, config, ... }:

{
  home.file."./config.toml".source = ./config.toml;
}
