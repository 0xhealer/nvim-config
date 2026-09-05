-- which-key: on-demand keybinding reference
require("which-key").setup({
	preset = "modern",
})

require("which-key").add({
	{ "<leader>b", group = "Buffers" },
	{ "<leader>c", group = "Code" },
	{ "<leader>d", group = "Diff" },
	{ "<leader>g", group = "Git" },
	{ "<leader>t", group = "Terminal" },
	{ "<leader>u", group = "UI" },
	{ "<leader>y", group = "Yank path" },
	{ "s", group = "Split / Window" },
	{ ";", group = "Find (Snacks)" },
})

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = true })
end, { noremap = true, silent = true, desc = "Show all keybindings (which-key)" })
