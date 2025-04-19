# {
#   programs.neovim =
#     let
#       toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
#     in
#     {
#       enable = true;
#       withPython3 = true;
#       extraLuaConfig = ''
#         vim.g.mapleader = ' '
#         vim.g.maplocalleader = ' '
#         vim.cmd.colorscheme 'catppuccin'
#         ${builtins.readFile ./config/load-after.lua}
#         ${builtins.readFile ./config/options.lua}
#         ${builtins.readFile ./config/groups.lua}
#         ${builtins.readFile ./config/keymaps.lua}
#       '';
#       plugins = with pkgs.vimPlugins; [
#         {
#           plugin = nvim-lspconfig;
#           config = toLuaFile ./config/plugins/nvim-lspconfig.lua;
#         }
#         neodev-nvim
#         fidget-nvim
#         {
#           plugin = nvim-cmp;
#           config = toLuaFile ./config/plugins/nvim-cmp.lua;
#         }
#         cmp-nvim-lsp
#         cmp_luasnip
#         cmp-path
#         {
#           plugin = indent-blankline-nvim;
#           config = toLuaFile ./config/plugins/indent-blankline.lua;
#         }
#         {
#           plugin = lualine-nvim;
#           config = toLuaFile ./config/plugins/lualine.lua;
#         }
#         telescope-nvim
#         {
#           plugin = which-key-nvim;
#           config = toLuaFile ./config/plugins/which-keys.lua;
#         }
#         catppuccin-nvim
#         {
#           plugin = mini-nvim;
#           config = toLuaFile ./config/plugins/mini.lua;
#         }
#         none-ls-nvim
#         conjure
#         vim-sleuth
#         barbar-nvim
#         nvim-web-devicons
#         {
#           plugin = neo-tree-nvim;
#           config = toLuaFile ./config/plugins/neo-tree.lua;
#         }
#         {
#           plugin = toggleterm-nvim;
#           type = "lua";
#           config = "require(\"toggleterm\").setup()";
#         }
#         {
#           plugin = nvim-notify;
#           type = "lua";
#           config = "vim.notify = require(\"notify\")";
#         }
#         {
#           plugin = dressing-nvim;
#           config = toLuaFile ./config/plugins/dressing.lua;
#         }
#         {
#           plugin = noice-nvim;
#           type = "lua";
#           config = "require(\"noice\").setup({})";
#         }
#         {
#           plugin = comment-nvim;
#           type = "lua";
#           config = "require(\"Comment\").setup({})";
#         }
#         {
#           plugin = conform-nvim;
#           config = toLuaFile ./config/plugins/conform.lua;
#         }
#         nui-nvim
#         luasnip
#         friendly-snippets
#         nvim-treesitter.withAllGrammars
#         nvim-treesitter-textobjects
#       ];
#     };
# }
{
  imports = [
    ./plugins/lsp.nix
    ./plugins/conform.nix
  ];
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };

    clipboard = {
      providers = {
        wl-copy.enable = true; # For Wayland
        xsel.enable = true; # For X11
      };

      register = "unnamedplus";
    };

    opts = {
      # Show line numbers
      number = true;
      # You can also add relative line numbers, to help with jumping.
      #  Experiment for yourself to see if you like it!
      #relativenumber = true

      # Enable mouse mode, can be useful for resizing splits for example!
      mouse = "a";

      # Don't show the mode, since it's already in the statusline
      showmode = false;

      # Enable break indent
      breakindent = true;

      # Save undo history
      undofile = true;

      # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
      ignorecase = true;
      smartcase = true;

      # Keep signcolumn on by default
      signcolumn = "yes";

      # Decrease update time
      updatetime = 250;

      # Decrease mapped sequence wait time
      # Displays which-key popup sooner
      timeoutlen = 300;

      # Configure how new splits should be opened
      splitright = true;
      splitbelow = true;

      # Sets how neovim will display certain whitespace characters in the editor
      #  See `:help 'list'`
      #  and `:help 'listchars'`
      list = true;
      # NOTE: .__raw here means that this field is raw lua code
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

      # Preview substitutions live, as you type!
      inccommand = "split";

      # Show which line your cursor is on
      cursorline = true;

      # Minimal number of screen lines to keep above and below the cursor.
      scrolloff = 10;

      # if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
      # instead raise a dialog asking if you wish to save the current file(s)
      # See `:help 'confirm'`
      confirm = true;

      # See `:help hlsearch`
      hlsearch = true;
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };

    # [[ Basic Autocommands ]]
    #  See `:help lua-guide-autocommands`
    # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
    autoCmd = [
      # Highlight when yanking (copying) text
      #  Try it with `yap` in normal mode
      #  See `:help vim.highlight.on_yank()`
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {
          desc = "Move focus to the left window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {
          desc = "Move focus to the right window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {
          desc = "Move focus to the lower window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {
          desc = "Move focus to the upper window";
        };
      }
    ];

    plugins = {
      lsp.enable = true;
      blink-cmp.enable = true;
      fidget.enable = true;
      lualine.enable = true;
      telescope.enable = true;
      none-ls.enable = true;
      barbar.enable = true;
      web-devicons.enable = true;
      neo-tree.enable = true;
      toggleterm.enable = true;
      snacks.enable = true;
      dressing.enable = true;
      noice.enable = true;
      conform-nvim.enable = true;
      nui.enable = true;
      luasnip.enable = true;
      friendly-snippets.enable = true;
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
