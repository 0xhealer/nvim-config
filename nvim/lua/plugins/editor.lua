local icons = require("utils.icons")

---@module 'blink.cmp'
---@type blink.cmp.Config
require("blink.cmp").setup({
	snippets = {
		preset = "default",
	},
	completion = {
		accept = {
			auto_brackets = {
				enabled = true,
			},
		},
		menu = {
			border = "none",
			draw = {
				treesitter = { "lsp" },
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = {
			-- TODO: Specify AI completion
			enabled = vim.g.ai_cmp,
		},
	},

	cmdline = {
		enabled = true,
		keymap = {
			preset = "cmdline",
			["<Right>"] = false,
			["<Left>"] = false,
			-- Explicit, matching the same reasoning as the main Insert-mode
			-- keymap block below: "cmdline" is a distinct preset from
			-- "default"/"enter"/"super-tab", not confirmed to inherit their
			-- Up/Down behavior, so set directly rather than assumed.
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
		},
		completion = {
			list = { selection = { preselect = false } },
			menu = {
				auto_show = function(ctx)
					return vim.fn.getcmdtype() == ":"
				end,
			},
			ghost_text = { enabled = true },
		},
	},

	keymap = {
		preset = "enter",
		["<C-y>"] = { "select_and_accept" },
		-- Explicit, rather than relying on the "enter" preset's documented
		-- (but here, apparently not-working) Up/Down fallback alongside C-n/C-p.
		["<Down>"] = { "select_next", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
	},

	appearance = {
		kind_icons = icons.kinds,
	},
})

require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = false },
	-- skip autopair when next character is one of these
	skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
	-- skip autopair when the cursor is inside these treesitter nodes
	skip_ts = { "string" },
	-- skip autopair when next character is closing pair
	-- and there are more closing pairs than opening pairs
	skip_unbalanced = true,
	-- better deal with markdown code blocks
	markdown = true,
})

require("mini.diff").setup({
	view = {
		-- show whole reference part above whole buffer part, as in `git diff`
		overlay_style = "hunk",
	},
	mappings = {
		-- same keymaps as codediff.nvim
		goto_next = "]c",
		goto_prev = "[c",
	},
})
require("todo-comments").setup()

require("gitsigns").setup()
require("gitlinker").setup()

local oxfmtFormatter = { "oxfmt", "prettierd", "prettier", stop_after_first = true }
require("conform").setup({
	default_format_opts = {
		timeout_ms = 3000,
		async = false,
		quiet = false,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		javascript = oxfmtFormatter,
		typescript = oxfmtFormatter,
		javascriptreact = oxfmtFormatter,
		typescriptreact = oxfmtFormatter,
		json = oxfmtFormatter,
		css = oxfmtFormatter,
		html = oxfmtFormatter,
		markdown = oxfmtFormatter,
		yaml = oxfmtFormatter,
		less = oxfmtFormatter,
		scss = oxfmtFormatter,
		["markdown.mdx"] = oxfmtFormatter,
		lua = { "stylua" },
		sh = { "shfmt" },
		fish = { "fish_indent" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		rust = { "rustfmt" },
		go = { "goimports", "gofumpt" },
		python = { "ruff_format" },
	},
	formatters = {
		oxfmt = {
			-- Treat oxfmt as available only when the project has an oxfmt config
			-- (.oxfmtrc.json / .oxfmtrc.jsonc). Without it, oxfmt is skipped and the
			-- formatter list falls back to prettier.
			require_cwd = true,
		},
	},
	format_on_save = function(bufnr)
		if vim.b[bufnr].disable_autoformat then
			return
		end
		return {
			timeout_ms = 500,
			lsp_fallback = true,
		}
	end,
})

vim.lsp.document_color.enable(false)
require("nvim-highlight-colors").setup({
	render = "background",
	enable_hex = true,
	enable_short_hex = true,
	enable_rgb = true,
	enable_hsl = true,
	enable_hsl_without_function = true,
	enable_ansi = true,
	enable_var_usage = true,
	enable_tailwind = false,
})
