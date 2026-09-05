<h1 align="center">Neovim Configuration</h1>

<p align="center">
  <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.12%2B-57A143?logo=neovim&logoColor=white">
  <img alt="Platform Linux" src="https://img.shields.io/badge/platform-Linux-FCC624?logo=linux&logoColor=white">
  <img alt="Platform Windows" src="https://custom-icon-badges.demolab.com/badge/platform-Windows-0078D6?logo=windows11&logoColor=white">
  <img alt="Made with Lua" src="https://img.shields.io/badge/made%20with-Lua-blueviolet?logo=lua&logoColor=white">
</p>

## Installation

**One-liner (clones/downloads and installs in one step):**

Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/0xhealer/nvim-config/main/bootstrap.sh | bash
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/0xhealer/nvim-config/main/bootstrap.ps1 | iex
```

**Manual — git clone:**

```bash
git clone https://github.com/0xhealer/nvim-config.git
cd nvim-config
./install.sh        # Linux
# or
.\install.ps1        # Windows
```

**Manual — ZIP download:** Code → Download ZIP on the repo page, extract it, then run `install.sh`/`install.ps1` from inside the extracted folder (same as above)

## Folder structure

```
nvim/
├── init.lua                     -- entrypoint, just requires core/ and plugins/
├── nvim-pack-lock.json          -- vim.pack's own lockfile (pinned plugin commits)
├── after/lsp/                   -- per-server overrides (only servers that
│   │                               need more than vim.lsp.enable's defaults)
│   ├── basedpyright.lua
│   ├── clangd.lua                 -- gcc query-driver, --enable-config, etc.
│   ├── cssls.lua
│   ├── gopls.lua
│   ├── jdtls.lua                  -- per-project workspace dir (required, not optional)
│   ├── lua_ls.lua
│   ├── oxlint.lua
│   ├── powershell_es.lua          -- bundle_path, pwsh, explicit filetypes
│   ├── ruff.lua
│   └── vtsls.lua
└── lua/
    ├── core/
    │   ├── autocmds.lua
    │   ├── commands.lua            -- :SkelC, :ToggleFormatter
    │   ├── keymaps.lua              -- non-plugin-specific keymaps
    │   └── options.lua
    ├── plugins/
    │   ├── init.lua                 -- vim.pack.add {} + require() chain
    │   ├── bufferline.lua
    │   ├── colorschemes.lua         -- all colorscheme setup() calls + picker keymap
    │   ├── editor.lua               -- blink.cmp, conform, mini.pairs/diff, gitsigns
    │   ├── keymaps.lua              -- plugin-dependent keymaps (LSP, Snacks, bufferline...)
    │   ├── lsp.lua                  -- mason + vim.lsp.enable list
    │   ├── multicursor.lua
    │   ├── statusline.lua
    │   ├── treesitter.lua
    │   ├── ui.lua                   -- snacks setup, diagnostics config, transparency
    │   ├── util.lua
    │   └── whichkey.lua
    ├── tools/                      -- see Credits
    │   ├── skeleton_c.lua           -- :SkelC
    │   ├── include_formatter.lua
    │   └── include_rename.lua       -- present, not yet wired (see TODO)
    └── utils/
        ├── editor.lua
        ├── icons.lua
        └── init.lua
```

## Plugins

**Colorschemes** (switch anytime with `<leader>uc`, live preview):

| Plugin                           | What it does        |
| -------------------------------- | ------------------- |
| `rose-pine/neovim`               | Default colorscheme |
| `catppuccin/nvim`                | Colorscheme         |
| `folke/tokyonight.nvim`          | Colorscheme         |
| `ellisonleao/gruvbox.nvim`       | Colorscheme         |
| `rebelot/kanagawa.nvim`          | Colorscheme         |
| `craftzdog/solarized-osaka.nvim` | Colorscheme         |

**Completion / LSP:**

| Plugin                                      | What it does                                                |
| ------------------------------------------- | ----------------------------------------------------------- |
| `saghen/blink.cmp`                          | Completion engine (LSP, snippets, path, buffer sources)     |
| `neovim/nvim-lspconfig`                     | Provides server configs consumed by native `vim.lsp.enable` |
| `mason-org/mason.nvim`                      | Installs/manages LSP servers, formatters, linters           |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | Auto-installs mason's `ensure_installed` list on startup    |

**Editing:**

| Plugin                            | What it does                                   |
| --------------------------------- | ---------------------------------------------- |
| `jake-stewart/multicursor.nvim`   | VSCode-style simultaneous multi-cursor editing |
| `nvim-mini/mini.pairs`            | Auto-closes brackets/quotes                    |
| `nvim-mini/mini.diff`             | Inline diff view against git                   |
| `stevearc/conform.nvim`           | Format-on-save, per-filetype formatters        |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting, indent, textobjects       |

**UI:**

| Plugin                               | What it does                                                  |
| ------------------------------------ | ------------------------------------------------------------- |
| `folke/snacks.nvim`                  | Fuzzy picker, floating terminal, notifications, lazygit, more |
| `akinsho/bufferline.nvim`            | Buffer tabs at the top of the window                          |
| `nvim-mini/mini.statusline`          | Statusline                                                    |
| `nvim-mini/mini.icons`               | Filetype/kind icons used throughout the UI                    |
| `b0o/incline.nvim`                   | Floating per-window filename label                            |
| `rachartier/tiny-cmdline.nvim`       | Floating command-line UI                                      |
| `brenoprata10/nvim-highlight-colors` | Highlights hex/rgb color codes inline                         |
| `folke/which-key.nvim`               | Keybinding hint popup                                         |

**Git:**

| Plugin                        | What it does                                               |
| ----------------------------- | ---------------------------------------------------------- |
| `lewis6991/gitsigns.nvim`     | Git change signs in the gutter, blame, hunk staging        |
| `linrongbin16/gitlinker.nvim` | Copy a permalink to the current line on GitHub/GitLab/etc. |
| `esmuellert/codediff.nvim`    | File/repo history diff viewer                              |

**Files:**

| Plugin                     | What it does                                      |
| -------------------------- | ------------------------------------------------- |
| `stevearc/oil.nvim`        | Edit directories as buffers (file explorer)       |
| `folke/todo-comments.nvim` | Highlights and lists `TODO`/`FIXME`/etc. comments |

## Credits

`lua/tools/skeleton_c.lua` and `include_formatter.lua` are adapted from [Salar](https://github.com/SalarAlo/neovim_configuration)'s own C++ tooling.

## TODO

Neovim 0.13 is still nightly-only as of writing

- [ ] Read `:help news-0.13` in full before touching anything below
- [ ] Re-check `vim.pack` (`lua/plugins/init.lua`) — newest built-in API in 0.12, most likely of everything here to have changed
- [ ] Re-check native LSP config (`vim.lsp.enable`/`vim.lsp.config`, `lua/plugins/lsp.lua` + `after/lsp/`) for any deprecations
- [ ] Re-check the native `'autocomplete'` option's interaction with `blink.cmp` (`lua/plugins/editor.lua`) — 0.12 added native insert-mode completion, worth confirming nothing changed there for 0.13
