{
  imports = [
    ./lsp.nix
    ./conform.nix
    ./blink.nix
    ./snacks.nix
    ./mini.nix
    ./neotree.nix
    ./telescope.nix
  ];
  programs.nixvim = {
    plugins = {
      lualine.enable = true;
      telescope.enable = true;
      none-ls.enable = true;
      barbar.enable = true;
      web-devicons.enable = true;
      toggleterm.enable = true;
      dressing.enable = true;
      noice.enable = true;
      nui.enable = true;
      luasnip.enable = true;
      friendly-snippets.enable = true;
      sleuth.enable = true;
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
        };
      };
      which-key = {
        enable = true;
        settings = {
          preset = "helix";
        };
      };
    };

  };
}
