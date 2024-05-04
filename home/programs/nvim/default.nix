{ pkgs, config, ... }:

{
  programs.neovim = 
  let 
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    withPython3 = true;
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      vim.cmd.colorscheme 'catppuccin'
      ${builtins.readFile ./config/load-after.lua}
      ${builtins.readFile ./config/options.lua}
      ${builtins.readFile ./config/groups.lua}
      ${builtins.readFile ./config/keymaps.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./config/plugins/nvim-lspconfig.lua;
      }
      neodev-nvim
      fidget-nvim
      {
        plugin = nvim-cmp;
        config = toLuaFile ./config/plugins/nvim-cmp.lua;
      }
      cmp-nvim-lsp
      cmp_luasnip
      cmp-path
      {
        plugin = indent-blankline-nvim;
        config = toLuaFile ./config/plugins/indent-blankline.lua;
      }
      {
        plugin = lualine-nvim;
        config = toLuaFile ./config/plugins/lualine.lua;
      }
      telescope-nvim
      {
        plugin = which-key-nvim;
        config = toLuaFile ./config/plugins/which-keys.lua;
      }
      catppuccin-nvim
      {
        plugin = mini-nvim;
        config = toLuaFile ./config/plugins/mini.lua;
      }
      none-ls-nvim
      conjure
      vim-sleuth
      barbar-nvim
      nvim-web-devicons
      {
        plugin = neo-tree-nvim;
        config = toLuaFile ./config/plugins/neo-tree.lua;
      }
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = "require(\"toggleterm\").setup()";
      }
      {
        plugin = nvim-notify;
        type = "lua";
        config = "vim.notify = require(\"notify\")";
      }
      {
        plugin = dressing-nvim;
        config = toLuaFile ./config/plugins/dressing.lua;
      }
      {
        plugin = noice-nvim;
        type = "lua";
        config = "require(\"noice\").setup({})";
      }
      {
        plugin = comment-nvim;
        config = toLuaFile ./config/plugins/comment.lua;
      }
      {
        plugin = conform-nvim;
        config = toLuaFile ./config/plugins/conform.lua;
      }
      nui-nvim
      luasnip
      friendly-snippets
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-lua
        p.tree-sitter-bash
        p.tree-sitter-go
        p.tree-sitter-python
      ]))
      nvim-treesitter-textobjects
    ];   

    # LSP Servers / Formatters / Linters
    extraPackages = with pkgs; [
      gopls
      nil
      nixpkgs-fmt
      ccls
      vscode-langservers-extracted
      htmx-lsp
      nodePackages.eslint
      prettierd
      stylua
      black
    ];
  };
}

