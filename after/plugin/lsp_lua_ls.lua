local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not ok then
    return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config['lua_ls'] = {
	cmd = { 'emmylua_ls' },
	filetypes = { 'lua' },
    capabilities = capabilities,
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			}
		}
	}
}

vim.lsp.enable('lua_ls')

