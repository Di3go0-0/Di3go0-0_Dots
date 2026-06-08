-- ─────────────────────────────────────────────────────────────────
-- Yazi init: registra plugins instalados vía ~/.config/yazi/package.toml
-- ─────────────────────────────────────────────────────────────────

-- Bordes en los 3 paneles
require("full-border"):setup({
  type = ui.Border.ROUNDED,
})

-- Git status inline (M / A / D / ? / !)
require("git"):setup()

-- Enter contextual: dir -> entrar | archivo -> abrir
require("smart-enter"):setup({})

-- Bookmarks tipo vim: m<char> marca, '<char> salta
require("bookmarks"):setup({
  last_directory = { enable = false, persist = false },
  persist        = "all",       -- "none" | "vim" | "all"
  desc_format    = "parent",    -- "parent" | "full"
  file_pick_mode = "hover",     -- "hover" | "select"
  notify         = {
    enable = true,
    timeout = 1,
    message = {
      new    = "Bookmark '<key>' -> <folder>",
      delete = "Bookmark '<key>' deleted",
      delete_all = "All bookmarks deleted",
    },
  },
})
