require("codecompanion").setup({
  interactions = {
    chat = { adapter = "openrouter" },
    inline = { adapter = "openrouter" },
  },
  adapters = {
    http = {
      openrouter = function()
        return require("codecompanion.adapters").extend("openai", {
          url = "https://openrouter.ai/api/v1/chat/completions",
          env = {
            api_key = function()
              return vim.fn.trim(vim.fn.system("cat ~/.config/openrouter/api_key"))
            end,
          },
          schema = {
            model = {
              default = "poolside/laguna-s-2.1:free",
            },
          },
        })
      end,
    },
  },
})
