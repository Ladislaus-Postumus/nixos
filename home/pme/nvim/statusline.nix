{lib, ...}: {
  statusline.lualine = {
    enable = true;
    setupOpts = {
      options = {
        section_separators = {
          left = "";
          right = "";
        };
        component_separators = {
          left = "";
          right = "";
        };
        disabled_filetypes.statusline = ["NvimTree" "TelescopePrompt"];
      };
      sections = {
        lualine_a = ["mode"];
        lualine_b = ["branch" "diff" "diagnostics"];
        lualine_c = ["filename"];
        lualine_x = ["encoding" "fileformat" "filetype"];
        lualine_y = ["progress"];
        lualine_z = ["location"];
      };
      tabline = lib.generators.mkLuaInline ''
        {
          lualine_a = { { 'buffers', mode = 4 } },
          lualine_z = { { 'tabs', mode = 2 } },
        }
      '';
    };
  };
}
