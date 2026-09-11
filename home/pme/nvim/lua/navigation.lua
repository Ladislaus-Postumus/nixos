local function smart_navigate(wincmd, tmux_direction)
  local initial_win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if initial_win == vim.api.nvim_get_current_win() then
    vim.fn.system("tmux select-pane -" .. tmux_direction)
  end
end

vim.keymap.set("n", "<C-h>", function() smart_navigate("h", "L") end)
vim.keymap.set("n", "<C-j>", function() smart_navigate("j", "D") end)
vim.keymap.set("n", "<C-k>", function() smart_navigate("k", "U") end)
vim.keymap.set("n", "<C-l>", function() smart_navigate("l", "R") end)
