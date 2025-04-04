{ pkgs, config, ... }:

{
  home.file.".config/anyrun/config.ron".source = ./config.ron;
  home.file.".config/anyrun/style.css".source = ./style.css;
  }
