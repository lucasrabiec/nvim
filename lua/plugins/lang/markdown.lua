---@class markview.config
---@field experimental? markview.config.experimental
---@field html? markview.config.html
---@field latex? markview.config.latex
---@field markdown? markview.config.markdown
---@field markdown_inline? markview.config.markdown_inline
---@field preview? markview.config.preview
---@field renderers? table<string, function>
---@field typst? markview.config.typst
---@field yaml? markview.config.yaml

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
