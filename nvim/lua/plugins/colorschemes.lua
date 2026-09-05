-- Colorschemes. apply_transparency()'s ColorScheme autocmd (ui.lua) is the
-- real safety net that makes every one of these actually match a transparent
-- terminal — the per-theme transparent option below is set too where trivial,
-- but ui.lua's generic sweep is what's doing the heavy lifting, same as it
-- already did for rose-pine alone before this file existed.

require("rose-pine").setup({
	variant = "auto",
	dark_variant = "main",
	dim_inactive_windows = false,
	extend_background_behind_borders = true,
	enable = {
		terminal = true,
		legacy_highlights = true,
		migrations = true,
	},
	styles = {
		bold = true,
		italic = true,
		transparency = true,
	},
})

require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, or mocha
	transparent_background = true,
})

require("tokyonight").setup({
	style = "night", -- storm, moon, night, or day
	transparent = true,
})

require("gruvbox").setup({
	transparent_mode = true,
})

require("kanagawa").setup({
	transparent = true,
	-- theme variant is picked via colorscheme name, not a setup option:
	-- "kanagawa" (wave, the default), "kanagawa-dragon", or "kanagawa-lotus"
})

-- This config's original colorscheme, before the swap to rose-pine earlier
-- on — same exact setup() it had then, just no longer the one loaded by
-- default at startup.
require("solarized-osaka").setup({
	style = "vivid",
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
	sidebars = {
		"qf",
		"vista_kind",
		"terminal",
		"spectre_panel",
		"startuptime",
		"Outline",
	},
})

-- Default on startup — change this line (or just use the picker below and
-- your pick sticks for the session) if you want a different one to load
-- by default going forward.
vim.cmd([[colorscheme rose-pine]])

-- Picker: Snacks.picker.colorschemes() (confirmed via snacks.nvim's own docs)
-- lists every colorscheme currently loaded/available — including all four
-- added above — with live preview as you move through the list, no extra
-- registration needed beyond what's already in vim.pack.add above.
-- Known snacks.nvim quirk (their bug, not fixable from config): cancelling
-- with <Esc> after previewing doesn't restore your original theme — you'll
-- end up on whatever you were last previewing, not back where you started.
vim.keymap.set("n", "<leader>uc", function()
	Snacks.picker.colorschemes()
end, { noremap = true, silent = true, desc = "Pick colorscheme (live preview)" })
