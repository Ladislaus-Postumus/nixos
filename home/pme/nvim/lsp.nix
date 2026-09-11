{lib, ...}: {
  languages = {
    enableDAP = true;
    enableExtraDiagnostics = true;
    enableFormat = true;
    enableTreesitter = true;

    bash.enable = true;
    clang.enable = true;
    cmake.enable = true;
    json.enable = true;
    lua.enable = true;
    markdown.enable = true;
    nix.enable = true;
    rust.enable = true;
    toml.enable = true;
    yaml.enable = true;
  };

  lsp = {
    enable = true;
    formatOnSave = true;
    trouble.enable = true;
  };

  diagnostics = {
    enable = true;
    config = {
      virtual_text = false;
      underline = true;
      signs = lib.generators.mkLuaInline ''
        {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
        }
      '';
      severity_sort = true;
      update_in_insert = false;
      float = {
        border = "none";
        source = "always";
      };
    };
  };
}
