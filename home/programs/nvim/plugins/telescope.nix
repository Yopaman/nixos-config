{
  programs.nixvim = {
    plugins.telescope.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader><leader>";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "Find files";
        };
      }
    ];
  };
}
