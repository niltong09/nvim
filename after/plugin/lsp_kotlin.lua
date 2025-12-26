local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
    return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config['kotlin'] = {
	cmd = { 'kotlin-lsp','--stdio' },
	filetypes = { 'kotlin' },
    capabilities = capabilities,
	root_markers = {
        'settings.gradle',
        'settings.gradle.kts',
        'pom.xml',
        'build.gradle',
        'build.gradle.kts',
        'workspace.json',
    },
}

vim.lsp.enable('kotlin')


