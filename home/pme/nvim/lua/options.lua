vim.o.colorcolumn = "120"
vim.o.conceallevel = 3
vim.o.concealcursor = 'nc'
vim.o.colorcolumn = "120"
vim.o.conceallevel = 3
vim.o.concealcursor = "nc"

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    pcall(vim.keymap.del, "n", "<leader>lf")
    vim.keymap.set("n", "<leader>lf", function()
      require("conform").format()
    end, { desc = "Format Buffer" })
  end,
})
