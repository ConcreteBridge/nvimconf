local g, opt, set = vim.g, vim.opt, vim.keymap.set

--[[ OPTIONS ]]
g.mapleader = ";"
g.maplocalleader = ";"

opt.cursorline = true
opt.cursorlineopt = "number"
opt.expandtab = true
opt.gdefault = true
opt.number = true
opt.scrolloff = 3
opt.shiftwidth = 2
opt.signcolumn = "yes:1"
opt.smartcase = true
opt.smartindent = true
opt.smarttab = true
opt.swapfile = false
opt.switchbuf = "usetab"
opt.tabstop = 2
opt.undofile = true
opt.wrap = false
opt.writebackup = false

--[[ PLUGINS ]]
vim.opt.rtp:prepend(vim.fn.stdpath "data" .. "/lazy/lazy.nvim")
require("lazy").setup {
  spec = {
    "zekzekus/menguless",
    "mhinz/vim-signify",
    { "kylechui/nvim-surround", opts = {} },
    { "jake-stewart/multicursor.nvim", branch = "1.0", opts = {} },
    {
      "ibhagwan/fzf-lua",
      opts = {
        "ivy",
        fzf_colors = true,
        winopts = { preview = { hidden = true } },
      },
    },
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      opts = { fuzzy = { implementation = "lua" } },
    },
    {
      "stevearc/conform.nvim",
      opts = {
        format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
        formatters = {
          ["clang-format"] = { args = { "--style=WebKit", "-assume-filename", "$FILENAME" } },
          sqlfluff = { args = { "format", "-" }, require_cwd = false },
        },
        formatters_by_ft = {
          c = { "clang-format" },
          cpp = { "clang-format" },
          lua = { "stylua" },
          mysql = { "sqlfluff" },
          python = { "ruff" },
          sql = { "sqlfluff" },
        },
      },
    },
  },
  install = { colorscheme = { "menguless" } },
  checker = { enabled = true },
}
vim.cmd.colorscheme "menguless"

--[[ KEYMAPS ]]
set("v", "<leader>s", "!sort<cr>", { silent = true })
set("v", "<leader>u", "!uniq<cr>", { silent = true })

local fzf = require "fzf-lua"
set("n", "<leader>G", function () fzf.grep_cword() end, { silent = true })
set("n", "<leader>b", function () fzf.buffers() end, { silent = true })
set("n", "<leader>f", function () fzf.files() end, { silent = true })
set("n", "<leader>g", function () fzf.live_grep_native() end, { silent = true })
set("n", "<leader>l", function () fzf.lines() end, { silent = true })
set("n", "<leader>o", function () fzf.oldfiles() end, { silent = true })
set("v", "<leader>g", function () fzf.grep_visual() end, { silent = true })

local mc = require "multicursor-nvim"
set("n", "C", function () mc.lineAddCursor(1) end, { silent = true })
set("n", "<M-C>", function () mc.lineAddCursor(-1) end, { silent = true })
set("n", ",", function () mc.clearCursors() end, { silent = true })
