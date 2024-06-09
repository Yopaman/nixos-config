{ pkgs, config, ... }:

{
  programs.rio = {
    enable = false;
    settings = {
      cursor = "|";
      editor = "nvim";
      padding-x = 10;
      window = {
        width = 600;
        height = 300;
        decorations = "Disabled";
        opacity = 0.9;
        background-opacity = 0.9;
        blur = true;
      };
      renderer = {
        performance = "High";
        backend = "Vulkan";
      };
      fonts = {
        family = "MonaspiceNe Nerd Font";
        size = 20;
      };
      bindings = {
        keys = [
          {
            key = "b";
            "with" = "control";
            action = "OpenConfigEditor";
          }
        ];
      };
    };
  };
}
