{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs.nvf.enable = true;
  programs.nvf.settings.vim = lib.mkMerge [
    (import ./editor.nix {inherit pkgs lib;})
    (import ./lsp.nix {inherit pkgs lib;})
    (import ./spell.nix {inherit pkgs;})
    (import ./statusline.nix {inherit lib;})
    (import ./ui.nix {})
    {keymaps = import ./keymaps.nix;}
    {
      extraPackages = [pkgs.gdtoolkit_4];
      luaConfigPost =
        builtins.readFile ./lua/options.lua
        + builtins.readFile ./lua/autocmds.lua
        + builtins.readFile ./lua/ai.lua
        + builtins.readFile ./lua/navigation.lua;
    }
  ];
}
