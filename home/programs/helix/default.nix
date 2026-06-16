{ pkgs, config, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
          };

languages.language = [
        {
          name = "nix";
          auto-format = true;
        }
      ];
  };
}
