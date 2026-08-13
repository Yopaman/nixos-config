{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./fish
    ./starship
    ./helix
    ./ghostty
    ./zed-editor
    ./niri
  ];

}
