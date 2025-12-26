local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
    return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config['phpactor'] = {
	cmd = { 'phpactor','language-server' },
    capabilities = capabilities,
	filetypes = { 'php', 'blade' },
	root_markers = { { 'composer.json' }, '.git' },
}

vim.lsp.enable('phpactor')


