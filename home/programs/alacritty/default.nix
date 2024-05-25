{ pkgs, config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
        import = ["/home/pablo/.config/alacritty/catppuccin-mocha.toml"];
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
          # decorations = "None";
          padding = {
            x = 15;
            y = 15;
          };
        };
        colors = {
          primary = {
            foreground = "#${config.colorScheme.palette.base05}";
            background = "#${config.colorScheme.palette.base00}";
            dim_foreground = "#${config.colorScheme.palette.base05}";
            bright_foreground = "#${config.colorScheme.palette.base05}";
          };
          cursor = {
              text = "#${config.colorScheme.palette.base00}";
              cursor = "#${config.colorScheme.palette.base06}";          
          };
          vi_mode_cursor = {
              text = "#${config.colorScheme.palette.base00}";
              cursor = "#${config.colorScheme.palette.base07}";          
          };
          search = {
            matches = {
              foreground = "#${config.colorScheme.palette.base0B}";
              background = "#${config.colorScheme.palette.base00}";            
            };
            focused_match = {
              foreground = "#${config.colorScheme.palette.base0B}";
              background = "#${config.colorScheme.palette.base00}";            
            };
          };
          footer_bar = {
            foreground = "#${config.colorScheme.palette.base0D}";
            background = "#${config.colorScheme.palette.base00}";          
          };
          hints = {
            start = {
              foreground = "#${config.colorScheme.palette.base01}";
              background = "#${config.colorScheme.palette.base00}";            
            };
            end = {
              foreground = "#${config.colorScheme.palette.base0D}";
              background = "#${config.colorScheme.palette.base00}";            
            };
          };
          selection = {
            text = "#${config.colorScheme.palette.base00}";
            background = "#${config.colorScheme.palette.base05}";          
          };
          normal = {
            black = "#${config.colorScheme.palette.base03}";          
            red = "#${config.colorScheme.palette.base08}";          
            green = "#${config.colorScheme.palette.base0B}";          
            yellow = "#${config.colorScheme.palette.base0A}";          
            blue = "#${config.colorScheme.palette.base0D}";          
            magenta = "#${config.colorScheme.palette.base0E}";          
            cyan = "#${config.colorScheme.palette.base0C}";          
            white = "#${config.colorScheme.palette.base05}";          
          };
          bright = {
            black = "#${config.colorScheme.palette.base03}";          
            red = "#${config.colorScheme.palette.base08}";          
            green = "#${config.colorScheme.palette.base0B}";          
            yellow = "#${config.colorScheme.palette.base0A}";          
            blue = "#${config.colorScheme.palette.base0D}";          
            magenta = "#${config.colorScheme.palette.base0E}";          
            cyan = "#${config.colorScheme.palette.base0C}";          
            white = "#${config.colorScheme.palette.base05}";  
          };
          dim = {           
            black = "#${config.colorScheme.palette.base03}";          
            red = "#${config.colorScheme.palette.base08}";          
            green = "#${config.colorScheme.palette.base0B}";          
            yellow = "#${config.colorScheme.palette.base0A}";          
            blue = "#${config.colorScheme.palette.base0D}";          
            magenta = "#${config.colorScheme.palette.base0E}";          
            cyan = "#${config.colorScheme.palette.base0C}";          
            white = "#${config.colorScheme.palette.base05}";  
          };
        };
    };
    
  };
  #home.file.".config/alacritty/catppuccin-mocha.toml".source = ./catppuccin-mocha.toml;
}
