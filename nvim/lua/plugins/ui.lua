local icons = require("utils.icons")

-- apply_transparency()'s ColorScheme autocmd is the safety net that makes
-- every colorscheme in plugins/colorschemes.lua actually match a transparent
-- terminal (Alacritty/Kitty/Windows Terminal) — kept colorscheme-agnostic
-- rather than assuming any one theme's own transparency option is complete.
-- Individual colorscheme setup() calls live in plugins/colorschemes.lua now,
-- not here — this file only owns the parts that apply regardless of which
-- one is active.
local function apply_transparency()
	local groups = {
		"Normal",
		"NormalNC",
		"NormalFloat",
		"FloatBorder",
		"FloatTitle",
		"SignColumn",
		"LineNr",
		"CursorLineNr",
		"EndOfBuffer",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"WinSeparator",
		"VertSplit",
		"Pmenu",
		"PmenuSel",
		"PmenuSbar",
		"PmenuThumb",
		"WhichKeyFloat",
		"WhichKeyNormal",
		"InclineNormal",
		"InclineNormalNC",
	}
	for _, group in ipairs(groups) do
		vim.api.nvim_set_hl(0, group, { bg = "none" })
	end
end

apply_transparency()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = apply_transparency,
})

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("snacks").setup({
	indent = { enabled = true },
	scroll = { enabled = false },
	picker = {
		enabled = true,
		sources = {
			files = { hidden = true },
			grep = { hidden = true },
		},
	},
	notifier = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	terminal = { enabled = true },
	lazygit = {
		enabled = true,
		configure = true, -- auto-sets nvim-remote preset & syncs theme
		theme = {
			activeBorderColor = { fg = "WarningMsg", bold = true },
		},
	},
})

require("tiny-cmdline").setup({
	position = {
		y = "20%",
	},
})

require("incline").setup({
	window = {
		margin = { vertical = 0, horizontal = 1 },
		zindex = 10,
	},
	hide = {
		cursorline = "smart",
	},
	render = function(props)
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
		if vim.bo[props.buf].modified then
			filename = "[+] " .. filename
		end

		local icon, hl = MiniIcons.get("file", filename)
		return { { icon, group = hl }, { " " }, { filename } }
	end,
})

require("codediff").setup({
	explorer = {
		auto_open_on_cursor = true,
		view_mode = "tree", -- "list" or "tree"
	},
	keymaps = {
		view = {
			toggle_stage = "<Space>",
		},
	},
})

vim.diagnostic.config({
	underline = true,
	-- Live diagnostics while still typing, not just after dropping to
	-- Normal mode. Genuine tradeoff, not a strict improvement -- code is
	-- transiently "wrong" mid-edit (unclosed paren, half-typed identifier),
	-- so this trades some extra visual noise for not having to leave
	-- Insert mode to see whether what you just typed is actually broken.
	update_in_insert = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
		format = function(diagnostic)
			return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
		end,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
		},
	},
})
