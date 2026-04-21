return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      vtsls = {
        settings = {
          typescript = {
            format = {
              enable = false,
            },
            preferences = {
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
              importModuleSpecifier = "shortest", -- shortest, relative, non-relative, project-relative
            },
          },
        },
      },
    },
  },
}
