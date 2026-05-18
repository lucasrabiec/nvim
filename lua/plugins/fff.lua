return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require("fff.download").download_or_build_binary()
  end,
  -- for nixos:
  -- build = "nix run .#release",
  opts = {
    debug = {
      enabled = true,
      show_scores = true,
    },
    layout = {
      height = 0.8,
      width = 0.6,
    },
    keymaps = {
      close = "<Esc>",
      select = "<CR>",
      select_split = "<C-h>",
      select_vsplit = "<C-v>",
      select_tab = "<C-t>",
      move_up = { "<Up>", "<C-p>", "<Tab>" },
      move_down = { "<Down>", "<C-n>", "<S-Tab>" },
      preview_scroll_up = "<C-u>",
      preview_scroll_down = "<C-d>",
      toggle_debug = "<F2>",
      cycle_grep_modes = "<C-g>",
      cycle_previous_query = "<C-Up>",
      toggle_select = "<C-s>",
      send_to_quickfix = "<C-q>",
      focus_list = "<leader>l",
      focus_preview = "<leader>p",
    },
  },
  lazy = false, -- the plugin lazy-initialises itself
  keys = {
    {
      "<leader>ff",
      function()
        require("fff").find_files()
      end,
      desc = "FFFind files",
    },
    {
      "<leader>/",
      function()
        require("fff").live_grep()
      end,
      desc = "LiFFFe grep",
    },
    {
      "<leader>fz",
      function()
        require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
      end,
      desc = "Live fffuzy grep",
    },
    {
      "<leader>fc",
      function()
        require("fff").live_grep({ query = vim.fn.expand("<cword>") })
      end,
      desc = "Search current word",
    },
  },
}
