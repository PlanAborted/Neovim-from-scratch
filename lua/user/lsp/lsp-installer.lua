local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end
local status_ok_2, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok_2 then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}

vim.lsp.set_log_level("debug")

lsp_installer.setup({
	ui = {
		icons = {
			server_installed = "",
			server_pending = "",
			server_uninstalled = "",
		},
	},
})

local tsserver_opts = require("user.lsp.settings.tsserver")
lspconfig.tsserver.setup(vim.tbl_deep_extend("force", tsserver_opts, opts))

-- local cucumber_opts = require("user.lsp.settings.cucumber_language_server")
-- lspconfig.cucumber_language_server.setup(vim.tbl_deep_extend("force", cucumber_opts, opts))

local prosemd_opts = require("user.lsp.settings.prosemd")
lspconfig.prosemd_lsp.setup(vim.tbl_deep_extend("force", prosemd_opts, opts))

local jsonls_opts = require("user.lsp.settings.jsonls")
lspconfig.jsonls.setup(vim.tbl_deep_extend("force", jsonls_opts, opts))

local sumneko_opts = require("user.lsp.settings.sumneko_lua")
lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", sumneko_opts, opts))

-- lsp_installer.on_server_ready(function(server)
--     if server.name == "jsonls" then
--         local jsonls_opts = require("user.lsp.settings.jsonls")
--         opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
--     end
--
--     if server.name == "sumneko_lua" then
--         local sumneko_opts = require("user.lsp.settings.sumneko_lua")
--         opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--     end
--
--     -- This setup() function is exactly the same as lspconfig's setup function.
--     -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--     server:setup(opts)
-- end)
