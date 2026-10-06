local function secret(path)
  return function()
    local ok, lines = pcall(vim.fn.readfile, vim.fn.expand(path))
    if not ok then
      vim.notify("CodeCompanion: cannot read " .. path, vim.log.levels.ERROR)
      return nil
    end
    return (table.concat(lines, ""):gsub("%s", ""))
  end
end

local function clean_terminal(text)
  text = text
    -- escape sequences, in case any ever slip through (OSC, CSI)
    :gsub("\27%][^\7\27]*\7", "")
    :gsub("\27%][^\27]*\27\\", "")
    :gsub("\27%[[%d;:?<=>]*[ -/]*[@-~]", "")
    -- private-use glyphs: Nerd Fonts / Powerline (U+E000-F8FF, and U+F0000+ for the md-* icons)
    :gsub(
      "\238[\128-\191][\128-\191]",
      ""
    )
    :gsub("\239[\128-\163][\128-\191]", "")
    :gsub("\243[\176-\191][\128-\191][\128-\191]", "")
    -- tidy up: trailing spaces, runs of blank lines, blank lines right before the closing fence
    :gsub(
      "[ \t]+\n",
      "\n"
    )
    :gsub("\n\n\n+", "\n\n")
    :gsub("\n+(`+)%s*$", "\n%1")
  return text
end

package.preload["ai_terminal_context"] = function()
  local Builtin = require("codecompanion.interactions.shared.editor_context.terminal")
  local M = {}

  function M.new(args)
    local chat = args.Chat
    if chat then
      -- hand the built-in context a view of the chat whose add_message cleans the text first
      args = vim.tbl_extend("force", args, {
        Chat = setmetatable({
          add_message = function(_, msg, opts)
            msg.content = clean_terminal(msg.content)
            return chat:add_message(msg, opts)
          end,
        }, { __index = chat }),
      })
    end
    local instance = Builtin.new(args)
    instance.cli_render = function(self)
      local rendered = Builtin.cli_render(self)
      if rendered then
        rendered.block = clean_terminal(rendered.block)
      end
      return rendered
    end
    return instance
  end

  return M
end

require("codecompanion").setup({
  adapters = {
    acp = {
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = { CLAUDE_CODE_OAUTH_TOKEN = secret("~/.config/claude-code/oauth_token") },
        })
      end,
    },
  },

  interactions = {
    chat = {
      adapter = "claude_code",
      tools = {
        opts = {
          default_tools = { "web_search" },
        },
        ["web_search"] = { opts = { adapter = "duckduckgo" } },
      },
      sessions = { autosave = true },
    },
    shared = {
      editor_context = {
        terminal = { path = "ai_terminal_context" },
      },
    },
  },
})
