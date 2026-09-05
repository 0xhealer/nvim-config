local gh = function(plugin)
	return "https://github.com/" .. plugin
end

vim.pack.add({
	{ src = gh("rose-pine/neovim"), name = "rose-pine" },
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	{ src = gh("folke/tokyonight.nvim") },
	{ src = gh("ellisonleao/gruvbox.nvim") },
	{ src = gh("rebelot/kanagawa.nvim") },
	{ src = gh("craftzdog/solarized-osaka.nvim") },
	{ src = gh("akinsho/bufferline.nvim") },
	{ src = gh("nvim-mini/mini.icons") },
	{ src = gh("nvim-mini/mini.statusline") },
	{ src = gh("folke/snacks.nvim") },
	{ src = gh("rachartier/tiny-cmdline.nvim") },

	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter") },
	{ src = gh("nvim-mini/mini.pairs") },
	{ src = gh("nvim-mini/mini.diff") },

	{ src = gh("saghen/blink.cmp"), version = vim.version.range("^1") },
	{ src = gh("jake-stewart/multicursor.nvim"), version = "1.0" },
	{ src = gh("folke/todo-comments.nvim") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("linrongbin16/gitlinker.nvim") },
	{ src = gh("brenoprata10/nvim-highlight-colors") },
	-- LSP
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("mason-org/mason.nvim") },
	{ src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
	-- Util
	{ src = gh("stevearc/oil.nvim") },
	-- UI
	{ src = gh("b0o/incline.nvim") },
	{ src = gh("esmuellert/codediff.nvim") },
	-- Which-key
	{ src = gh("folke/which-key.nvim") },
})

require("plugins.colorschemes")
require("plugins.statusline")
require("plugins.bufferline")
require("plugins.ui")
require("plugins.treesitter")
require("plugins.editor")
require("plugins.multicursor")
require("plugins.lsp")
require("plugins.util")
require("plugins.keymaps")
require("plugins.whichkey")
