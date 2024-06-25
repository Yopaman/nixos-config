{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      ls = {
        body = "eza --icons";
      };
    };
  };
}
