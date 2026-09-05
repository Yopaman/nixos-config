{ pkgs, config, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      ls = {
        body = "eza --icons";
      };
      cdtmp = {
        body = "cd (mktemp -d)";
      };
    };
  };
}
