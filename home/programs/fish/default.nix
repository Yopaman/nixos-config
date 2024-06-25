{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    function = {
      ls = {
        body = "eza --icons";
      };
    };
  };
}
