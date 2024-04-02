{ pkgs, config, ... }:

{
  home.file.".config/swaync/config.json".source = ./config.json;
  home.file.".config/swaync/style.css".source = ./style.css;
}

