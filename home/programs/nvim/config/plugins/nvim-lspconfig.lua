require("neodev").setup({})
require("fidget").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- LSP Servers
local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
	cmd = { "rust-analyzer" },
	["rust-analyzer"] = {
		checkOnSave = {
			command = "clippy",
		},
	},
})

lspconfig.nil_ls.setup({
	autostart = true,
	capabilities = caps,
	cmd = { "nil" },
	settings = {
		["nil"] = {
			testSetting = 42,
			formatting = {
				command = { "nixpkgs-fmt" },
			},
		},
	},
})

lspconfig.racket_langserver.setup({})

lspconfig.clangd.setup({})

lspconfig.html.setup({})

lspconfig.htmx.setup({})

lspconfig.gopls.setup({})

lspconfig.eslint.setup({})

lspconfig.zls.setup({})
