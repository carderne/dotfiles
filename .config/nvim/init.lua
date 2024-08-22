-- -----------------------------------------------------------------------------------------------
-- General configuration
-- -----------------------------------------------------------------------------------------------
-- Basic settings
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.spelllang = "en_gb"

-- use nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Use system clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- Display settings
vim.opt.termguicolors = true
vim.opt.background = "light"

-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.wrap = false

-- Title
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to

-- Persist undo
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

-- Tab stuff
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- scroll a bit extra horizontally and vertically when at the end/bottom
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8

-- open new split panes to right and below (as you probably expect)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Highlight trailing characters
vim.opt.listchars = {
	-- eol = "↲",
	tab = "▸ ",
	trail = "·",
}
vim.opt.list = true

-- LSP
vim.lsp.inlay_hint.enable() -- doesn't seem to do anything...

-- -----------------------------------------------------------------------------------------------
-- Keymap settings
-- -----------------------------------------------------------------------------------------------
-- Basic keys
vim.g.mapleader = ","
vim.keymap.set("n", "<space>", ":")
vim.keymap.set("n", "<leader>ec", ":e $MYVIMRC<CR>")

-- Easier redo
vim.keymap.set("n", "q", "<C-r>")

-- Search navigation
-- n is always forward, N is always backward
-- ' is now forward and ; is backward
vim.keymap.set("n", "n", "v:searchforward ? 'n' : 'N'", { expr = true })
vim.keymap.set("n", "N", "v:searchforward ? 'N' : 'n'", { expr = true })
vim.keymap.set("n", ";", "getcharsearch().forward ? ',' : ';'", { expr = true })
vim.keymap.set("n", "'", "getcharsearch().forward ? ';' : ','", { expr = true })

-- Search and Replace
vim.keymap.set("n", "<leader>h", ":%s/")
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR><C-L>")

-- nvim-tree
vim.keymap.set("n", "<C-t>", ":NvimTreeFocus<CR>")
vim.keymap.set("n", "<C-f>", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<C-c>", ":NvimTreeClose<CR>")

-- toggle line numbers and wrap
vim.keymap.set("n", "<leader>n", ":set nonumber! relativenumber!<CR>")
vim.keymap.set("n", "<leader>w", ":set wrap! wrap?<CR>")

-- Moving between splits and resizing
vim.keymap.set("n", "<C-j>", "<C-W><C-J>")
vim.keymap.set("n", "<C-k>", "<C-W><C-K>")
vim.keymap.set("n", "<C-l>", "<C-W><C-L>")
vim.keymap.set("n", "<C-H>", "<C-W><C-H>")
vim.keymap.set("n", "<C-w>k", ":resize +15<CR>")
vim.keymap.set("n", "<C-w>j", ":resize -15<CR>")
vim.keymap.set("n", "<C-w>h", ":vertical:resize -15<CR>")
vim.keymap.set("n", "<C-w>l", ":vertical:resize +15<CR>")

-- -----------------------------------------------------------------------------------------------
-- Plugin list
-- -----------------------------------------------------------------------------------------------

local plugins = {
	-- Gruvbox theme with Treesitter support
	{ "ellisonleao/gruvbox.nvim" },

	-- Used by LuaLine and nvim-tree
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	},

	-- Pretty indentation lines
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl" },

	-- Status line at the bottom
	{ "nvim-lualine/lualine.nvim" },

	-- File browser
	{ "nvim-tree/nvim-tree.lua" },

	-- LSP-Zero
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		},
	},

	-- None-LS
	{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "jay-babu/mason-null-ls.nvim" },

	-- TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		priority = 1000,
		lazy = false,
		version = nil,
		build = ":TSUpdate",
	},
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- Telescope
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Pest/PEG
	-- { "pest-parser/pest.vim" },

	-- DAP
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	dependencies = {
	-- 		{ "mfussenegger/nvim-dap" },
	-- 		{ "mfussenegger/nvim-dap-python" },
	-- 		{ "jay-babu/mason-nvim-dap.nvim" },
	-- 		{ "williamboman/mason.nvim" },
	-- 	},
	-- },

	-- gitsigns
	{ "lewis6991/gitsigns.nvim" },

	-- NeoGit
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"sindrets/diffview.nvim", -- optional - Diff integration
	-- 	},
	-- 	config = true,
	-- },

	{ "ggandor/leap.nvim" },

	-- { "andythigpen/nvim-coverage" },
}

-- -----------------------------------------------------------------------------------------------
-- Plugin installation
-- -----------------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)

-- require("coverage").setup()

-- -----------------------------------------------------------------------------------------------
-- Plugin config
-- -----------------------------------------------------------------------------------------------
vim.cmd("colorscheme gruvbox")

require("nvim-tree").setup({
	filters = {
		dotfiles = true,
	},
})

require("ibl").setup({
	debounce = 100,

	indent = { char = "▏" },
	whitespace = { highlight = { "Whitespace", "NonText" } },
	-- scope = { enabled = false },
})

require("lualine").setup({
	sections = {
		lualine_a = {},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

require("telescope").setup({
	pickers = {
		find_files = {
			theme = "ivy",
		},
		live_grep = {
			theme = "ivy",
		},
	},
})

local tele_builtin = require("telescope.builtin")
-- vim.keymap.set("n", "<leader>ff", tele_builtin.git_files, {})
-- vim.keymap.set("n", "<leader>ff", tele_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", tele_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", tele_builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", tele_builtin.help_tags, {})
vim.keymap.set("n", "<leader>ff", function()
	tele_builtin.find_files({
		search_dirs = { vim.fn.expand("%:p:h") },
	})
end, {})

require("gitsigns").setup({ current_line_blame = true })

require("leap").add_default_mappings()

-- -----------------------------------------------------------------------------------------------
-- Treesitter
-- -----------------------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	-- https://github.com/nvim-treesitter/nvim-treesitter/tree/master#supported-languages
	ensure_installed = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"python",
		"javascript",
		"typescript",
		"go",
		"sql",
		"bash",
		-- "beancount",
		"css",
		"diff",
		"dockerfile",
		"git_rebase",
		"html",
		"jq",
		"json",
		"latex",
		"markdown",
		"rust",
		"terraform",
		"yaml",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- -----------------------------------------------------------------------------------------------
-- LSP stuff
-- -----------------------------------------------------------------------------------------------
local cmp = require("cmp")
local cmp_format = require("lsp-zero").cmp_format()
cmp.setup({
	formatting = cmp_format,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "path", max_item_count = 6 },
	}, {
		{ name = "buffer" },
	}),
	-- preselect = "item",
	-- completion = {
	-- autocomplete = false,
	-- completeopt = "menu,menuone,noinsert",
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "insert" }),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "insert" }), -- or select
	}),
})

local lsp_zero = require("lsp-zero")
local lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr }
	lsp_zero.default_keymaps(opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	-- nnoremap <silent> ca <cmd>lua vim.lsp.buf.code_action()<CR>
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gd", tele_builtin.lsp_definitions, opts)
	vim.keymap.set("n", "gr", tele_builtin.lsp_references, opts)
end
lsp_zero.extend_lspconfig({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	lsp_attach = lsp_attach,
	float_border = "rounded",
	sign_text = true,
})

require("mason").setup({})
require("mason-lspconfig").setup({
	-- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
	ensure_installed = {
		"tsserver",
		"basedpyright",
		-- "pyright",
		"ruff",
		"eslint",
		"bashls",
		-- "beancount",
		"cssls",
		"dockerls",
		"docker_compose_language_service",
		"gopls",
		"html",
		"jsonls",
		"lua_ls",
		"rust_analyzer",
		"sqlls",
		"terraformls",
		"yamlls",
		"pest_ls",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})

require("lspconfig").rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
})

lsp_zero.format_mapping("<leader>fo", {
	format_opts = {
		async = true,
		timeout_ms = 10000,
	},
	servers = {
		["null-ls"] = { "javascript", "typescript", "lua", "go", "json", "typescriptreact" },
		["rust_analyzer"] = { "rust" },
		["ruff"] = { "python" },
	},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.jq,
		null_ls.builtins.formatting.gofmt,
		-- null_ls.builtins.formatting.ruff,
	},
})
require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
})

-- -----------------------------------------------------------------------------------------------
-- DAP
-- -----------------------------------------------------------------------------------------------
-- require("mason-nvim-dap").setup({
-- 	ensure_installed = { "python" },
-- })
--
-- require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
--
-- local dap = require("dap")
-- local dapui = require("dapui")
-- dapui.setup()
-- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
-- dap.listeners.before.event_exited["dapui_config"] = dapui.close
--
-- vim.keymap.set("n", "<leader>bb", dapui.toggle)
-- vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint)
-- vim.keymap.set("n", "<leader>bn", dap.continue)
-- vim.keymap.set("n", "<leader>bl", dap.step_over)
-- vim.keymap.set("n", "<leader>bj", dap.step_into)
-- vim.keymap.set("n", "<leader>bk", dap.step_out)
-- vim.keymap.set("n", "<leader>bh", dap.step_back)
-- vim.keymap.set("n", "<leader>b.", dap.run_last)

-- -----------------------------------------------------------------------------------------------
-- Filetype-specific settings
-- -----------------------------------------------------------------------------------------------
-- Spell check certain file types
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "latex", "tex", "md", "markdown" },
	callback = function()
		vim.opt.spell = true
		vim.opt.wrap = true
		vim.opt.linebreak = true
	end,
})

-- Beancount
vim.filetype.add({
	extension = {
		bean = "beancount",
	},
})

vim.diagnostic.config({
	virtual_text = {
		source = true,
		format = function(diagnostic)
			if diagnostic.user_data and diagnostic.user_data.code then
				return string.format("%s %s", diagnostic.user_data.code, diagnostic.message)
			else
				return diagnostic.message
			end
		end,
	},
	signs = true,
	float = {
		header = "Diagnostics",
		source = true,
		border = "rounded",
	},
})
