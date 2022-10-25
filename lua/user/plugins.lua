local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	max_jobs = 5,
	preview_updates = false, -- If true, always preview updates before choosing which plugins to update, same as `PackerUpdate --preview`.
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
		keybindings = { -- Keybindings for the display window
			quit = "q",
			toggle_update = "u", -- only in preview
			continue = "c", -- only in preview
			toggle_info = "<CR>",
			diff = "d",
			prompt_revert = "r",
		},
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use({ "akinsho/bufferline.nvim", branch = "main" })
	use("moll/vim-bbye")
	use("nvim-lualine/lualine.nvim")
	use({ "akinsho/toggleterm.nvim", branch = "main" })
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use("folke/which-key.nvim")
	use("winston0410/smart-cursor.nvim")

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("folke/tokyonight.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use({ "jose-elias-alvarez/null-ls.nvim", compile = "76d0573fc159839a9c4e62a0ac4f1046845cdd50" }) -- for formatters and linters
	use("jose-elias-alvarez/nvim-lsp-ts-utils") -- for formatters and linters
	use("ray-x/lsp_signature.nvim")
	use({ "williamboman/mason.nvim", commit = "c2002d7a6b5a72ba02388548cfaf420b864fbc12" }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim", commit = "0051870dd728f4988110a1b2d47f4a4510213e31" })
	use("jayp0521/mason-null-ls.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use({
		"nvim-treesitter/nvim-treesitter-context",
	})

	-- Git
	use("lewis6991/gitsigns.nvim")
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Hop
	use("phaazon/hop.nvim")

	-- Smoothie
	use("psliwka/vim-smoothie")

	-- AutoSession
	use("rmagatti/auto-session")

	-- Nvim Notify
	use("rcarriga/nvim-notify")

	-- Dressing (Native NVIM UI look)
	use({ "stevearc/dressing.nvim" })

	-- Fidget (Nvim LSP notif)
	use("j-hui/fidget.nvim")

	-- Nvim Surround
	use("kylechui/nvim-surround")

	-- Vim Startuptime
	use("dstein64/vim-startuptime")

	-- Overseer (task runner)
	use("stevearc/overseer.nvim")

	-- Presenting
	use("sotte/presenting.vim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
