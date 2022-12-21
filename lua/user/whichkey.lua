local mappings = {
	[" "] = { "<cmd>HopWord<cr>", "Jump to pattern" },
	["<cr>"] = { "<cmd>Telescope resume<cr>", "Telescope resume" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"[B]uffers",
	},
	["c"] = { "<cmd>tabclose<CR>", "[C]lose tab" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "[E]xplorer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No [H]ighlight" },
	["n"] = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node Terminal" },
	["q"] = { "<cmd>q!<CR>", "[Q]uit" },
	["s"] = { "<cmd>w!<CR>", "[S]ave" },
	["S"] = { "<cmd>noa w!<CR>", "[S]ave without autoformat" },
	["t"] = { "<cmd>MindToggleMain<cr>", "Toggle Mind" },
	["u"] = { "<cmd>OverseerToggle<cr>", "Overseer Toggle" },
	["w"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },

	f = {
		name = "[F]ind",
		f = { "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<cr>", "[F]ind Text in [F]ile" },
		p = { "<cmd>Telescope live_grep theme=ivy<cr>", "[F]ind Text in [P]roject" },
	},

	P = {
		name = "[P]acker",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	m = {
		name = "[M]arkdown Preview",
		m = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle" },
		a = { "<cmd>MarkdownPreview<cr>", "Start" },
		s = { "<cmd>MarkdownPreviewStop<cr>", "Stop" },
	},

	g = {
		name = "[G]it",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "LazyGit" },
		h = { "<cmd>DiffviewFileHistory %<CR>", "Git file history" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		l = { "<cmd>lua _GITLOG_TOGGLE()<cr>", "Git Log" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		c = { "<cmd>G commit<cr>", "Git commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	j = {
		name = "[J]ump",
		b = { "<cmd>BufferLinePick<cr>", "Jump to Buffer" },
		l = { "<cmd>lua require'hop'.hint_lines()<cr>", "Jump to Line" },
		r = { "<cmd>Telescope lsp_references<cr>", "Jump to References" },
		w = { "<cmd>lua require'hop'.hint_words()<cr>", "Jump to Word" },
	},

	l = {
		name = "[L]SP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
		d = {
			"<cmd>Telescope diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>Mason<cr>", "Mason Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		--[[ l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" }, ]]
		--[[ q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" }, ]]
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		R = { "<cmd>LspRestart<cr>", "Restart LSP" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
		q = { "<cmd>copen<cr>", "Quickfix list" },
	},

	o = {
		name = "[O]pen",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		f = { "<cmd>Telescope git_files<cr>", "Open File" },
		g = { "<cmd>Telescope git_status<cr>", "Open Git changed files" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	p = {
		name = "[P]NPM (run custom)",
		i = {
			"<cmd>lua require('user.overseer-custom-templates').run('install',false)<cr>",
			"Install current package",
		},
		I = { "<cmd>lua require('user.overseer-custom-templates').run('install',true)<cr>", "Install all packages" },
		b = { "<cmd>lua require('user.overseer-custom-templates').run('build',false)<cr>", "Build current package" },
		B = { "<cmd>lua require('user.overseer-custom-templates').run('build',true)<cr>", "Build all packages" },
		t = { "<cmd>lua require('user.overseer-custom-templates').run('test',false)<cr>", "Test current package" },
		p = {
			"<cmd>lua require('user.overseer-custom-templates').run('plugins:package',true)<cr>",
			"Package plugins",
		},
		w = {
			"<cmd>lua require('user.overseer-custom-templates').run('watch',false)<cr>",
			"Watch current package",
		},
		d = { "<cmd>lua require('user.custom').dcDown()<cr>", "Docker-compose down" },
		u = { "<cmd>lua require('user.custom').dcUp()<cr>", "Docker-compose up" },
		o = { "<cmd>lua require('user.custom').openBash()<cr>", "Open bash here" },
		O = { "<cmd>lua require('user.custom').openBashRoot()<cr>", "Open bash in Root" },
		j = { "<cmd>OverseerToggle<cr>", "Overseer Toggle" },
	},
}

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		--[[ ["<space>"] = "SPC", ]]
		--[[ ["<cr>"] = "ENTER", ]]
		--[[ ["<CR>"] = "ENTER", ]]
		--[[ ["<tab>"] = "TAB", ]]
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 5, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)
which_key.register(mappings, opts)
