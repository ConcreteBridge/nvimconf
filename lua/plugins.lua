local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = "ibhagwan/fzf-lua" }
later(function ()
  require("fzf-lua").setup {
    "fzf-vim",
    fzf_colors = true,
  }
end)

add {
  source = "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  checkout = "v1.7.0",
}
later(function () require("blink.cmp").setup() end)

add { source = "numToStr/FTerm.nvim" }

add {
  source = "kristijanhusak/vim-dadbod-ui",
  depends = { "tpope/vim-dadbod", "kristijanhusak/vim-dadbod-completion" },
}
vim.g.db_ui_save_location = vim.fn.stdpath "data"
vim.g.db_ui_use_nerd_fonts = 1

add {
  source = "nvim-treesitter/nvim-treesitter",
  checkout = "main",
  hooks = {
    post_checkout = function () vim.cmd "TSUpdate" end,
  },
}
later(function ()
  require("nvim-treesitter").setup {
    install_dir = vim.fn.stdpath "data" .. "/site",
  }
end)

add { source = "neovim/nvim-lspconfig" }
later(function ()
  vim.lsp.enable "stylua"
  vim.lsp.enable "ruff"
  vim.lsp.enable "zls"
end)

add { source = "stevearc/conform.nvim" }
later(
  function ()
    require("conform").setup {
      format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff" },
        zig = { "zigfmt" },
      },
    }
  end
)

add { source = "dgagn/diagflow.nvim" }
later(function () require("diagflow").setup() end)

add { source = "mhinz/vim-signify" }

add { source = "kylechui/nvim-surround" }
later(function () require("nvim-surround").setup() end)

add { source = "numToStr/Comment.nvim" }
later(function () require("Comment").setup() end)

add { source = "olivercederborg/poimandres.nvim" }
now(function ()
  require("poimandres").setup { groups = { background = "#000000" } }
  vim.cmd.colorscheme "poimandres"
end)

add { source = "nvim-lualine/lualine.nvim" }
later(
  function ()
    require("lualine").setup {
      options = {
        theme = "poimandres",
        section_separators = "",
        component_separators = "",
      },
    }
  end
)

add { source = "folke/snacks.nvim" }
now(
  function ()
    require("snacks").setup {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
    }
  end
)

add { source = "folke/which-key.nvim" }
later(function () require("which-key").setup { icons = { mappings = false } } end)
