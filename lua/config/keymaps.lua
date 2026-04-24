-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

local del = vim.api.nvim_del_keymap

del("n", "<leader><tab>l")
del("n", "<leader><tab>f")
del("n", "<leader><tab><tab>")
del("n", "<leader><tab>]")
del("n", "<leader><tab>d")
del("n", "<leader><tab>[")
del("n", "<c-_>")

vim.api.nvim_set_keymap("n", "Q", "<Nop>", {})

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Center on scrolling
map("n", "<C-u>", "<cmd>lua vim.cmd('normal! <C-u>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")
map("n", "<C-d>", "<cmd>lua vim.cmd('normal! <C-d>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")
map("n", "<C-f>", "<cmd>lua vim.cmd('normal! <C-f>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")
map("n", "<C-b>", "<cmd>lua vim.cmd('normal! <C-b>zz'); MiniAnimate.execute_after('scroll', 'normal! zz')<cr>")

-- Other

local function mapResize(directions)
  map("n", directions.up, "<cmd>resize +2<cr>", { desc = "Increase window height" })
  map("n", directions.down, "<cmd>resize -2<cr>", { desc = "Decrease window height" })
  map("n", directions.left, "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
  map("n", directions.right, "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
end

if vim.fn.has("mac") == 1 then
  mapResize({ up = "<A-Up>", down = "<A-Down>", left = "<A-Left>", right = "<A-Right>" })
  del("n", "<C-Up>")
  del("n", "<C-Down>")
  del("n", "<C-Left>")
  del("n", "<C-Right>")
end

require("which-key").add({
  { "<leader><tab>", hidden = true },
  { "gp", group = "preview" },
  { "<leader>n", group = "npm package" },
  { "<leader>S", group = "spectre" },
})

vim.keymap.set("n", "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true })

vim.keymap.set("n", "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true })

-- Override Lazygit keys by Neogit
local neogit = require("neogit")

vim.keymap.set("n", "<leader>gg", function()
  neogit.open({ cwd = LazyVim.root.git() })
end, { desc = "Neogit (Root Dir)" })

vim.keymap.set("n", "<leader>gG", function()
  neogit.open()
end, { desc = "Neogit (cwd)" })

vim.keymap.set("n", "<leader>gb", Snacks.git.blame_line, { desc = "Git Blame Line" })

del("n", "<leader>gB")
map("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "Current File History" })

vim.keymap.set("n", "<leader>gl", neogit.action("log", "log_current"), { desc = "Neogit Log Current" })

del("n", "<leader>gL")
vim.keymap.set("n", "<leader>L", Snacks.dashboard.open, { desc = "Open Dashboard" })

-- C-c Esc
vim.keymap.set({ "n", "i" }, "<C-c>", "<Esc>")

-- Copy current buffer path and cursor position (/path/file:line)
vim.keymap.set("n", "<leader>yp", function()
  local full = vim.fn.expand("%:p")

  -- try to find git root
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  local rel
  if root and root ~= "" and vim.fn.isdirectory(root) == 1 then
    rel = full:gsub("^" .. root .. "/", "")
  else
    local cwd = vim.fn.getcwd()
    rel = full:gsub("^" .. cwd .. "/", "")
  end

  vim.fn.setreg("+", rel)
  print("Copied: " .. rel)
end, { desc = "Copy smart relative path" })

-- Copy current buffer path and cursor position (/path/file:line)
vim.keymap.set("n", "<leader>yl", function()
  local full = vim.fn.expand("%:p")
  local line = vim.fn.line(".")

  -- try to find git root
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

  local rel
  if root and root ~= "" and vim.fn.isdirectory(root) == 1 then
    rel = full:gsub("^" .. root .. "/", "")
  else
    local cwd = vim.fn.getcwd()
    rel = full:gsub("^" .. cwd .. "/", "")
  end

  local text = rel .. ":" .. line

  vim.fn.setreg("+", text)
  print("Copied: " .. text)
end, { desc = "Copy smart relative path with line" })

-- Copy current buffer path as link to GitHub
vim.keymap.set("n", "<leader>yg", function()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")

  -- git root
  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not root or root == "" then
    print("Not a git repo")
    return
  end

  -- relative path
  local rel = file:gsub("^" .. root .. "/", "")

  -- repo url
  local remote = vim.fn.systemlist("git config --get remote.origin.url")[1]

  -- branch
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

  if not remote or remote == "" then
    print("No remote origin")
    return
  end

  -- SSH → HTTPS
  remote = remote:gsub("git@github.com:", "https://github.com/"):gsub("%.git$", "")

  local url = remote .. "/blob/" .. branch .. "/" .. rel .. "#L" .. line

  vim.fn.setreg("+", url)
  print("Copied: " .. url)
end, { desc = "Copy GitHub link (line)" })

-- Copy current buffer path as link with lines range
vim.keymap.set("v", "<leader>yg", function()
  local file = vim.fn.expand("%:p")

  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  -- upewnij się że start <= end
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not root or root == "" then
    print("Not a git repo")
    return
  end

  local rel = file:gsub("^" .. root .. "/", "")

  local remote = vim.fn.systemlist("git config --get remote.origin.url")[1]
  local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]

  if not remote or remote == "" then
    print("No remote origin")
    return
  end

  remote = remote:gsub("git@github.com:", "https://github.com/"):gsub("%.git$", "")

  local range = "#L" .. start_line .. "-L" .. end_line
  local url = remote .. "/blob/" .. branch .. "/" .. rel .. range

  vim.fn.setreg("+", url)
  print("Copied: " .. url)
end, { desc = "Copy GitHub link (lines range)" })
