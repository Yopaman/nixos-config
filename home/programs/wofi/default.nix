{ pkgs, config, ... }:

{
  home.file.".config/wofi/config".source = ./config;
}
