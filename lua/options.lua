vim.diagnostic.config { underline = true }

local g = vim.g
local opt = vim.opt

g.mapleader = ";"
g.localmapleader = ";"

do
  opt.number = true
  opt.cursorline = true
  opt.laststatus = 3
  opt.showmode = false
end

opt.updatetime = 250
opt.timeoutlen = 400

opt.conceallevel = 2
opt.infercase = true
opt.shortmess:append "sWcI"
opt.signcolumn = "yes:1"
opt.formatoptions = { "q", "j" }
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

opt.splitright = true
opt.splitbelow = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

vim.schedule(function () opt.clipboard = "unnamedplus" end)
opt.mouse = "nv"

opt.undofile = true
opt.writebackup = false
opt.swapfile = false

opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true

opt.scrolloff = 6

opt.list = true
opt.listchars = { tab = "» ", trail = "•", nbsp = "␣" }
