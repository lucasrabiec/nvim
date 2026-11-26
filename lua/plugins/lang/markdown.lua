return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,

    -- For blink.cmp's completion
    dependencies = {
      "saghen/blink.cmp",
    },

    opts = {
      preview = {
        hybrid_modes = { "n" },
        linewise_hybrid_mode = true,
      },
    },
  },
}
