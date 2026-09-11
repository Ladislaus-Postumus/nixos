vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
})
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  callback = function()
    vim.lsp.buf.clear_references()
  end,
})

-- assigns a separate colour to float/floatborder from stylix so noice hover panes look better
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = vim.g.base16_gui01 })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = vim.g.base16_gui03, bg = vim.g.base16_gui01 })
  end,
})
vim.cmd("doautocmd ColorScheme")
