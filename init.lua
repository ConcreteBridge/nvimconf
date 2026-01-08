--[[ Options ]]
local g, opt, mapkey = vim.g, vim.opt, vim.keymap.set

g.mapleader = ";"
g.maplocalleader = ","

opt.breakindent = true
opt.expandtab = true
opt.foldlevel = 99
opt.gdefault = true
opt.ignorecase = true
opt.linebreak = true
opt.list = true
opt.listchars = { tab = "» ", trail = "•", nbsp = "␣" }
opt.number = true
opt.scrolloff = 3
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.swapfile = false
opt.undofile = true
opt.wrap = false
opt.writebackup = false

mapkey("v", "<leader>s", "!sort<cr>", { silent = true })
mapkey("v", "<leader>u", "!uniq<cr>", { silent = true })

--[[ Packages ]]
local path_package = vim.fn.stdpath "data" .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/nvim-mini/mini.deps", mini_path }
  vim.cmd "packadd mini.nvim | helptags ALL"
end
require("mini.deps").setup { path = { package = path_package } }

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- add { source = "blazkowolf/gruber-darker.nvim" }
-- now(function () vim.cmd.colorscheme "gruber-darker" end)
vim.cmd.colorscheme "vim"

add { source = "mhinz/vim-signify" }

add { source = "ibhagwan/fzf-lua" }
now(function ()
  local fzf = require "fzf-lua"
  fzf.setup { "ivy", fzf_colors = true, winopts = { border = "none", preview = { hidden = true } } }
  mapkey("n", "<leader>b", function () fzf.buffers() end, { silent = true })
  mapkey("n", "<leader>f", function () fzf.files() end, { silent = true })
  mapkey("n", "<leader>g", function () fzf.live_grep() end, { silent = true })
  mapkey("n", "<leader>l", function () fzf.lines() end, { silent = true })
  mapkey("n", "<leader>o", function () fzf.oldfiles() end, { silent = true })
end)

add { source = "kylechui/nvim-surround" }
later(function () require("nvim-surround").setup() end)

add {
  source = "nvim-treesitter/nvim-treesitter",
  checkout = "main",
  hooks = {
    post_checkout = function () vim.cmd "TSUpdate" end,
  },
}
now(function ()
  local tree = require "nvim-treesitter"
  tree.setup { install_dir = vim.fn.stdpath "data" .. "/site" }
  tree.install { "c", "lua", "python" }

  if vim.fn.executable("tree-sitter") == 1 then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "lua", "python" },
      callback = function ()
        vim.treesitter.start()
        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo.foldmethod = "expr"
        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
      end,
    })
  end
end)
