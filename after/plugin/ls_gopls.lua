vim.lsp.config['gopls'] = {
	cmd = { 'gopls' },
	filetypes = { 'go' },
	root_markers = { { 'go.mod' }, '.git' },
}

vim.lsp.enable('gopls')

vim.lsp.config['templ'] = {
	cmd = { 'templ', 'lsp' },
	filetypes = { 'templ' },
	root_markers = { 'go.work', 'go.mod' , '.git' },
}

vim.lsp.enable('templ')
