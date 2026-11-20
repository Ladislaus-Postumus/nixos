vim.keymap.set("n", "q:", ":q", { desc = "typo guard: q: → :q" })

-- capitalised variants from fumbling shift
for _, cmd in ipairs({ "Q", "W", "Wq", "WQ", "Qa", "Wa", "QA", "WA", "Wqa", "WQa", "WQA" }) do
  vim.api.nvim_create_user_command(cmd, cmd:lower() .. "<bang>", { bang = true })
end
