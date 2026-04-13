return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- pyright = {
      --   settings = {
      --     python = {
      --       analysis = {
      --         -- typeCheckingMode = "off",
      --         autoImportCompletions = true,
      --       },
      --     },
      --   },
      -- },
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              diagnosticMode = "workspace", -- "openFilesOnly"
              autoImportCompletions = true, -- offer auto-import completions
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              -- change this for less strict checking (less errors)
              -- typeCheckingMode = "standard", -- basedpyright default is "recommended" - ["off", "basic", "standard", "strict", "recommended", "all"]
              diagnosticSeverityOverrides = {
                -- https://docs.basedpyright.com/latest/configuration/config-files/#type-check-diagnostics-settings
                -- one of: error, warning, information, true, false, none
                reportMissingTypeStubs = "information", -- import has no type stub file
                reportUnusedCallResult = false, -- call statements with return value that is not used (e.g. not _ = call())
                reportMissingParameterType = false, -- function or method input parameters without type definition
                -- reportOptionalMemberAccess = "warning",  -- access to member of object that has Optional[] type (e.g. obj.append() on Optional[list])
                reportUnknownArgumentType = false, -- unknown (not statically typed/not inferrable) types
                reportUnknownLambdaType = false,
                reportUnknownMemberType = false,
                reportUnknownParameterType = false,
                reportUnknownVariableType = false,
                reportMissingSuperCall = "information",
                reportCallIssue = "warning",
                reportUnannotatedClassAttribute = "information",
                -- include basedpyright-only options, even if "standard" is selected (defaults to only in "all")
                -- https://docs.basedpyright.com/latest/configuration/config-files/#basedpyright-exclusive-settings_2
                reportAny = false, -- bans all usage of 'Any' type
                reportExplicitAny = false, -- bans all usage of 'Any' type
                reportIgnoreCommentWithoutRule = "warning",
                reportUnreachable = "error",
                reportPrivateLocalImportUsage = "error",
                reportImplicitRelativeImport = "error",
                reportInvalidCast = "error",
              },
            },
          },
        },
      },
    },
  },
}
