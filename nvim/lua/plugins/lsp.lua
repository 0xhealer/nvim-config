require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"prettier",
		"prettierd",
		"selene",
		"shellcheck",
		"shfmt",
		"stylua",
		"eslint-lsp",
		"oxlint",
		"oxfmt",
		"tailwindcss-language-server",
		"vtsls",
		"rust-analyzer",
		-- "rustfmt" deliberately NOT here — Mason deprecated this package
		-- (confirmed: mason-org/mason.nvim#1429). rustfmt is meant to come from
		-- `rustup component add rustfmt` instead, which install.sh's rustcall()
		-- already gets for free — rustup's default install profile includes
		-- rustfmt and clippy alongside rustc/cargo. Leaving this in ensure_installed
		-- is exactly what produced "Cannot find package 'rustfmt'".
		"clangd",
		"clang-format",
		-- Python
		"basedpyright",
		"ruff",
		-- Go
		"gopls",
		"goimports",
		"gofumpt",
		-- CSS / HTML / Markdown
		"css-lsp",
		"html-lsp",
		"marksman",
		-- Shell / data / infra
		"bash-language-server",
		"json-lsp",
		"yaml-language-server",
		"dockerfile-language-server",
		-- Java / PHP / C# / Ruby — genuinely missing before despite install.sh
		-- installing the JDK/php/dotnet-sdk/ruby toolchains themselves; the
		-- system package and the editor's LSP server are two separate things,
		-- and only the former was ever wired up.
		"jdtls",
		"phpactor",
		"omnisharp",
		"solargraph",
		-- PowerShell. See after/lsp/powershell_es.lua for why this one needs
		-- a dedicated file (unlike phpactor/solargraph, it can't run with
		-- bare defaults). Works identically on Linux and Windows in terms of
		-- what Mason installs — only whether pwsh itself is present locally
		-- differs, which is a separate, OS-level concern outside this file.
		"powershell-editor-services",
	},
	auto_update = false,
	run_on_start = true,
})

local capabilities = {
	workspace = {
		fileOperations = {
			didRename = true,
			willRename = true,
		},
	},
}
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
})

vim.lsp.enable({
	"eslint",
	"oxlint",
	"lua_ls",
	"cssls",
	"html",
	"vtsls",
	"tailwindcss",
	"glsl_analyzer",
	"rust_analyzer",
	"clangd",
	"basedpyright",
	"ruff",
	"gopls",
	"marksman",
	"bashls",
	"jsonls",
	"yamlls",
	"dockerls",
	"jdtls",
	"phpactor",
	"omnisharp",
	"solargraph",
	"powershell_es",
})
