{
  programs.nixvim = {
    enable = true;
    plugins.blink-cmp = {
      enable = true;
      settings = {
        appearance = {
          nerd_font_variant = "normal";
          use_nvim_cmp_as_default = false;
        };
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
              semantic_token_resolution = {
                enabled = false;
              };
            };
          };
          documentation = {
            auto_show = true;
          };
          list.selection.preselect = false;
        };
        keymap = {
          preset = "enter";
        };
        signature = {
          enabled = true;
        };
        sources = {
          cmdline = [ ];
          providers = {
            buffer = {
              score_offset = -7;
            };
            lsp = {
              fallbacks = [ ];
            };
          };
        };
      };
    };
  };
}
