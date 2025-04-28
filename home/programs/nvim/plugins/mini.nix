{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      modules = {
        ai = { };
        pairs = { };
        surround = { };
      };
    };
  };
}
