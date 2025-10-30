local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add { source = "ibhagwan/fzf-lua" }
later(
  function ()
    require("fzf-lua").setup {
      "fzf-vim",
      fzf_colors = true,
    }
  end
)

add {
  source = "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  checkout = "v1.7.0",
}
later(function () require("blink.cmp").setup() end)

add { source = "dgagn/diagflow.nvim" }
later(function () require("diagflow").setup() end)

add { source = "lewis6991/gitsigns.nvim" }
later(function () require("gitsigns").setup() end)

add {
  source = "nvim-treesitter/nvim-treesitter",
  checkout = "main",
  hooks = {
    post_checkout = function () vim.cmd "TSUpdate" end,
  },
}
later(
  function ()
    require("nvim-treesitter").setup {
      install_dir = vim.fn.stdpath "data" .. "/site",
    }
  end
)

add { source = "kylechui/nvim-surround" }
later(function () require("nvim-surround").setup() end)

add { source = "miikanissi/modus-themes.nvim" }
now(function ()
  require("modus-themes").setup { style = "vivendi" }
  vim.cmd.colorscheme "modus"
end)

add { source = "nvim-lualine/lualine.nvim" }
later(function ()
  require("lualine").setup {
    options = { section_separators = "", component_separators = "" },
  }
end)

add { source = "numToStr/FTerm.nvim" }

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

add { source = "folke/which-key.nvim" }
later(
  function () require("which-key").setup { icons = { mappings = false } } end
)
