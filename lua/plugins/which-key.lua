return {
  "folke/which-key.nvim",
  opts = {
    preset = "classic",
    spec = {
      -- overrides LazyVim's "hunks" label
      { "<leader>gh", group = "Diffview Open", mode = { "n", "x" } },
    },
    win = {
      border = "single",
    },
  },
}
