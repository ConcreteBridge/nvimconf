local map = vim.keymap.set

map("n", "<leader>f", function () require("fzf-lua").files() end, { desc = "files" })
map("n", "<leader>b", function () require("fzf-lua").buffers() end, { desc = "buffers" })
map("n", "<leader>g", function () require("fzf-lua").live_grep_native() end, { desc = "grep" })
map("v", "<leader>g", function () require("fzf-lua").grep_cword() end, { desc = "grep word" })
map("n", "<leader>l", function () require("fzf-lua").lines() end, { desc = "lines" })
map("n", "<leader>o", function () require("fzf-lua").oldfiles() end, { desc = "oldfiles" })
map("n", "<leader>z", function () require("fzf-lua").zoxide() end, { desc = "zoxide" })

map("n", "<leader>t", "", { desc = "+Terminal" })
map("n", "<leader>tt", function () require("FTerm").toggle() end, { desc = "term" })
map("n", "<leader>tj", function () require("FTerm").scratch { cmd = { "just" } } end, { desc = "just" })
map("n", "<leader>tl", function () require("FTerm").scratch { cmd = { "lazygit" } } end, { desc = "lazygit" })
