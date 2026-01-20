local jetpackfile = vim.fn.stdpath "data" .. "/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim"
local jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if vim.fn.filereadable(jetpackfile) == 0 then
  vim.fn.system(string.format("curl -fsSLo %s --create-dirs %s", jetpackfile, jetpackurl))
end

--[[ OPTIONS ]]
local g, opt = vim.g, vim.opt

g.mapleader = ";"
g.maplocalleader = ","

opt.breakindent = true
opt.breakindentopt = "list:-1"
opt.complete = { ".", "w", "b", "kspell" }
opt.completeopt = { "menuone", "noselect", "fuzzy", "popup" }
opt.cursorline = true
opt.cursorlineopt = "number"
opt.expandtab = true
opt.foldlevel = 99
opt.gdefault = true
opt.guifont = "Input Mono Narrow:h15"
opt.ignorecase = true
opt.linebreak = true
opt.list = true
opt.listchars = { tab = "» ", trail = "•", nbsp = "␣" }
opt.number = true
opt.ruler = false
opt.scrolloff = 3
opt.shortmess = "CFOSWaco"
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.swapfile = false
opt.switchbuf = "usetab"
opt.undofile = true
opt.wrap = false
opt.writebackup = false

vim.diagnostic.config {
  signs = { priority = 9999 },
  underline = true,
  virtual_lines = false,
  virtual_text = false,
}

--[[ KEYMAPS ]]
local mapkey = vim.keymap.set
mapkey("v", "<leader>s", "!sort<cr>", { silent = true })
mapkey("v", "<leader>u", "!uniq<cr>", { silent = true })

mapkey("n", "<leader>b", function () require("fzf-lua").buffers() end, { silent = true })
mapkey("n", "<leader>c", function () require("fzf-lua").grep_cword() end, { silent = true })
mapkey("n", "<leader>f", function () require("fzf-lua").files() end, { silent = true })
mapkey("n", "<leader>g", function () require("fzf-lua").live_grep() end, { silent = true })
mapkey("n", "<leader>l", function () require("fzf-lua").lines() end, { silent = true })
mapkey("n", "<leader>o", function () require("fzf-lua").oldfiles() end, { silent = true })

mapkey("n", "<leader>d", function () vim.diagnostic.open_float() end, { silent = true })

--[[ PACKAGES ]]
vim.cmd.packadd "vim-jetpack"
require "jetpack.paq" {
  { "tani/vim-jetpack" }, -- bootstrap
  { "ibhagwan/fzf-lua" },
  { "jesseleite/nvim-noirbuddy", requires = { "tjdevries/colorbuddy.nvim" } },
  { "kylechui/nvim-surround" },
  { "mhinz/vim-signify" },
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter" },
  { "saghen/blink.cmp", requires = { "rafamadriz/friendly-snippets" } },
  { "stevearc/conform.nvim" },
}

local jetpack = require "jetpack"
for _, name in ipairs(jetpack.names()) do
  if not jetpack.tap(name) then
    jetpack.sync()
    break
  end
end

require("noirbuddy").setup { preset = "miami-nights" }

if vim.fn.executable "tree-sitter" == 1 then
  local tree = require "nvim-treesitter"
  tree.setup { install_dir = vim.fn.stdpath "data" .. "/site" }
  tree.install { "c", "lua" }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "lua" },
    callback = function () vim.treesitter.start() end,
  })

  vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.wo.foldmethod = "expr"
  vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
end

require("fzf-lua").setup {
  "ivy",
  fzf_colors = true,
  winopts = { border = "none", preview = { hidden = true } },
}

-- vim.lsp.enable "clangd"

require("blink.cmp").setup {
  fuzzy = { implementation = "lua" },
}

require("nvim-surround").setup()

require("conform").setup {
  format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
  formatters = {
    ["clang-format"] = { args = { "--style=WebKit", "-assume-filename", "$FILENAME" } },
  },
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
  },
}
