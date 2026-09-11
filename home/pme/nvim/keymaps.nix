[
  {
    mode = [
      "n"
      "i"
    ];
    key = "<C-q>";
    action = "vim.lsp.buf.hover";
    lua = true;
    silent = true;
    desc = "Hover Documentation";
  }
  {
    mode = "n";
    key = "<leader>xx";
    action = "<cmd>Trouble diagnostics toggle<cr>";
    desc = "Toggle Diagnostics (Trouble)";
  }
  {
    mode = "n";
    key = "<leader>xt";
    action = "<cmd>Trouble todo toggle<cr>";
    desc = "Toggle TODOs (Trouble)";
  }
  {
    mode = "n";
    key = "<leader>e";
    action = "vim.diagnostic.open_float";
    lua = true;
    silent = true;
    desc = "Show line diagnostics";
  }
  {
    mode = "n";
    key = "<leader>gt";
    action = "<cmd>Gitsigns toggle_signs<cr>";
    desc = "Toggle Git Signs";
  }
  {
    mode = "n";
    key = "<leader>n";
    action = "<cmd>Navbuddy<cr>";
    desc = "Navbuddy";
  }
  {
    mode = "n";
    key = "<leader>lf";
    action = "<cmd>lua require('conform').format()<cr>";
    desc = "Format Buffer";
  }
]
