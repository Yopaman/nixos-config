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
          type = "lua";
          config = "require(\"Comment\").setup({})";
        }
        {
          plugin = conform-nvim;
          config = toLuaFile ./config/plugins/conform.lua;
        }
        nui-nvim
        luasnip
        friendly-snippets
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
      ];
    };
}
