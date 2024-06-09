{ pkgs, config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 12;
        normal = {
          family = "MonaspiceNe Nerd Font";
          style = "Regular";
        };
        bold_italic = {
          family = "MonaspiceNe Nerd Font";
          style = "Bold Italic";
        };
        bold = {
          family = "MonaspiceNe Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "MonaspiceNe Nerd Font";
          style = "Italic";
        };
      };
      window = {
        opacity = 0.9;
        decorations = "None";
        padding = {
          x = 15;
          y = 15;
        };
      };
      cursor.style = "Beam";
    };

  };
}
